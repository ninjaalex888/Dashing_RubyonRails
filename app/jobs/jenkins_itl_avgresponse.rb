Dashing.scheduler.every '25m', :first_in => 2, allow_overlapping: false do |job|

  if Rails.application.config.all_widgets

    Rails.application.config.all_widgets.each do |c|
      if c.widget_typeid == 14
          jtlFile = JenkinsHelper.get_jtl(c.jobname)
          totalResponseTime = 0
          count = 0
          jtlFile.each_line do |e|  
            splitFile = e.split(",")
            totalResponseTime = totalResponseTime + splitFile[1].to_i
            count = count + 1
          end
          avgResponseTime = totalResponseTime/count
          Dashing.send_event(c.id, {current: avgResponseTime})
          Rails.application.config.GLOBAL_CACHE[c.id]["current"]=avgResponseTime
          Rails.application.config.GLOBAL_CACHE[c.id]["updated"]="Last updated at "+Time.current.in_time_zone("US/Pacific").strftime("%H:%M") 
          
      end

    end

  end

end