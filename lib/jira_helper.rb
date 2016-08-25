class JiraHelper

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.days_in_month(month, year = Time.now.year)
   return 29 if month == 2 && Date.gregorian_leap?(year)
   COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def self.runQuery(jqlString)
    #load config
    if File.exist?('./config/initializers/config_userpass.yml')
      config_data = YAML.load_file('./config/initializers/config_userpass.yml')
    end

    url =  "https://coupadev.atlassian.net"
    username = ENV['JIRA_USER'] || config_data['jira']['user']
    password = ENV['JIRA_PASSWORD'] || config_data['jira']['pass']
    jql = CGI.escape(jqlString)
    uri = URI.parse("#{url}/rest/api/2/search?jql=" + jql + "&maxResults=100")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri.request_uri)

    # add basic auth
    request.basic_auth(username, password)
    response = http.request(request)

    json = response.body

    totalIssues = JSON.parse(json)["total"]
    return json
  end

  def self.runQueryComponents(jqlString, jqlStart)
    #load config
    if File.exist?('./config/initializers/config_userpass.yml')
      config_data = YAML.load_file('./config/initializers/config_userpass.yml')
    end

    url =  "https://coupadev.atlassian.net"
    username = ENV['JIRA_USER'] || config_data['jira']['user']
    password = ENV['JIRA_PASSWORD'] || config_data['jira']['pass']
    jql = CGI.escape(jqlString)
    jqlStart = jqlStart.to_s + "000"
    puts jqlStart
    uri = URI.parse("#{url}/rest/api/2/search?jql=" + jql + "&maxResults=100&startAt=" + jqlStart)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri.request_uri)

    # add basic auth
    request.basic_auth(username, password)
    response = http.request(request)

    json = response.body

    totalIssues = JSON.parse(json)["total"]
    return json
  end

  def self.getNumberOfIssues(jqlString)
    json = self.runQuery(jqlString)
    JSON.parse(json)["total"]
  end

  def self.getsprint(jqlString)
    time=Time.current
    year=time.year.to_s
    month=start_date=end_date=nil
    today=time.day
    json=JiraHelper.runQuery(jqlString)
    
    try=0
    loop do
        jsonparsed=JSON.parse(json)['issues'][try]['fields']['customfield_10800'][0]
        puts ''
        puts jsonparsed
        chars=jsonparsed.split('')
        i,count=0,0
        start_date,end_date='',''
        while i<chars.length do
            if chars[i]=='/'
                if count==0
                    count=1
                    if chars[i-2]==' '
                        month=chars[i-1]
                    else
                        month=chars[i-2]+chars[i-1]
                    end
                    if chars[i+2]=='-'
                        start_date=chars[i+1]
                        if chars[i+4]='/'
                            end_month=chars[i+3]
                        else
                            end_month=chars[i+3]+chars[i+4]
                        end
                    else
                        start_date=chars[i+1]+chars[i+2]
                        if chars[i+5]='/'
                            end_month=chars[i+4]
                        else
                            end_month=chars[i+4]+chars[i+5]
                        end
                    end
                else
                    if chars[i+2]==','
                        end_date=chars[i+1]
                    else
                        end_date=chars[i+1]+chars[i+2]
                    break
                    end
                end
            end
            i+=1
        end
        try+=1
        puts ''
        puts month.to_i, end_date.to_i, today, time.month, end_month.to_i
        puts month!=nil
        puts end_date.to_i>=today
        puts month.to_i==time.month
        puts end_month.to_i>time.month
        puts (month!=nil and (end_date.to_i>=today and month.to_i==time.month or end_month.to_i>time.month))
        break if (month!=nil and (end_date.to_i>=today and month.to_i==time.month or end_month.to_i>time.month))
        # break if true
    end
    month_abre=Date::MONTHNAMES[(month.to_i)%12][0..2]
    puts ''
    puts ''
    puts ''
    puts "**********************get sprint got**********************"
    puts time, year, month, month_abre, start_date, today, end_date
    return time, year, month, month_abre, start_date, today, end_date
  end


  def self.sprint_burndown(jqlString)

    time, year, month, month_abre, start_date, today, end_date=JiraHelper.getsprint(jqlString)
    unfinished_str=" and status was not in (closed, resolved) ON "
    
    time_formatted=" ON \""+time.to_s[0..9].gsub('-','/')[0..-3]+start_date+"\""
    today_formated="\""+time.to_s[0..9].gsub('-','/')[0..-3]+today.to_s+"\""
    tickets=JiraHelper.getNumberOfIssues(jqlString)
    unfinished=JiraHelper.getNumberOfIssues(jqlString+unfinished_str+today_formated)
    half_tickets=tickets/2.to_f
    step=half_tickets/5.to_f
    p1=tickets
    p2=p1-step
    p3=p2-step
    p4=p3-step
    p5=p4-step
    p6=p5-step
    p7=p6
    p8=p7-step
    p9=p8-step
    p10=p9-step
    p11=p10-step
    p12=0
    ps=[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12]
    i=0
    j=1
    end_date=end_date.to_i
    start_date=start_date.to_i
    if end_date<start_date
      end_date+=self.days_in_month(month.to_i)
    end
    dates=Array(start_date..end_date)
    dates[0]=month_abre+" "+dates[0].to_s
    progress=Array.new(12,Fixnum)
    progress[0]=tickets
    while j<12 do
      if dates[j]<=today
        
        ql="\""+time.to_s[0..9].gsub('-','/')[0..-3]+dates[j].to_s+"\""
        progress[j]=JiraHelper.getNumberOfIssues(jqlString+unfinished_str+ql)
      else
        progress[j]=nil
      end
      if dates[j]>self.days_in_month(month.to_i)
        dates[j]=Date::MONTHNAMES[(month.to_i+1)%12][0..2]+" "+(dates[j]-self.days_in_month(month.to_i)).to_s
      else
        dates[j]=month_abre+" "+dates[j].to_s
      end
      j+=1
    end
    return dates, ps, progress,unfinished, tickets
  end

  def self.build_components_table(jqlString)#assuming jqlString is @sprint, might need to change 
    json=JiraHelper.runQuery(jqlString)
    totalIssues = JSON.parse(json)["total"]
    @status_hash={"Open"=>0, "Reopened"=>1, "In Progress"=>2, "Code Review"=>3, "Code Propagation"=>4, "Ready to Merge"=>5, "Resolved"=>6, "Closed"=>7}
    
    hashHash = Hash.new({})
    jsonparsed1=JSON.parse(json)['issues']
    jsonIssues = totalIssues / 100
    count = 0
    num = 0
    didntParseCount = 0
    while count <= jsonIssues do 
      if count > 0
        
        json=JiraHelper.runQueryComponents(jqlString, count)
        jsonparsed1 = JSON.parse(json)['issues']
        
        num = 0
      end

      while num < 100 do 
        
        jsonparsed = jsonparsed1[num]['fields']

        component_name = jsonparsed['components'][0]['name']
        status = jsonparsed['status']['name']

        if @status_hash.keys.include?(status)
          if hashHash.has_key?(component_name)
            hashHash[component_name][status] += 1
          else
            hashHash[component_name] = Hash["Open" => 0, "Reopened" => 0, "In Progress"=>0, "Code Review"=>0, "Code Propagation"=>0, "Ready to Merge"=>0, "Resolved"=>0, "Closed"=>0]
           
            hashHash[component_name][status] += 1
          end
        else 
        end
        checkCount = count.to_s + "00"
        if (checkCount.to_i + num) == (totalIssues - 1)
          break
        end

       
        num = num + 1
      end

      count = count + 1
    end

    return hashHash
  end

  def self.synergy(jqlString)
    time, year, month, month_abre, start_date, today, end_date=JiraHelper.getsprint(jqlString)
    unfinished_str=" and status was not in (closed, resolved) ON "
    
    time_formatted=" ON \""+time.to_s[0..9].gsub('-','/')[0..-3]+start_date+"\""
    today_formated="\""+time.to_s[0..9].gsub('-','/')[0..-3]+today.to_s+"\""
    tickets=JiraHelper.getNumberOfIssues(jqlString)
    unfinished=JiraHelper.getNumberOfIssues(jqlString+unfinished_str+today_formated)
    return tickets, unfinished
    
  rescue Timeout::Error => e
  end

end