Dashing.scheduler.every '30m', :first_in => 2, allow_overlapping: false do |job|
  if Rails.application.config.all_widgets
    Rails.application.config.all_widgets.each do |c|
      if c.widget_typeid == 13
        jtlFile = JenkinsHelper.get_jtl(c.jobname.to_s)
        totalResponseTime = 0
        count = 0
        responseHash = {}
        jtlFile.each_line do |e|  
            splitFile = e.split(",")
            responseCode = splitFile[3].to_s
                if responseHash.has_key?(responseCode) && responseCode != ""
                    responseHash[responseCode] = responseHash[responseCode] + 1
                elsif responseCode == ""
                elsif responseCode != "responseCode"
                  responseHash[responseCode] = 1
                end
                  count = count + 1
        end
        responseArray = responseHash.to_a
        responseTable = [['Response Code', 'Count #']]
        count1 = 0
        while count1 < responseArray.length
                #puts responseTable
                responseTable.append(responseArray[count1])
                count1 = count1 + 1
        end
       Dashing.send_event(c.id, points: responseTable)
       Rails.application.config.GLOBAL_CACHE[c.id]["responseT"]=responseTable
       Rails.application.config.GLOBAL_CACHE[c.id]["urlLink"]="https://jenkins.coupadev.com/job/" +c.jobname.to_s
       
      end
    end
  end
end