require 'net/http'
require 'yaml'
require 'uri'
require 'nokogiri'
require 'teamcity_helper'

def updateTCWidget(widgetId, jobname, color)
  msg = 'testing'
  if color == :red
    status = 'Failed'
    msg = 'Build Failed'
    health = 5
  elsif color == :green
    status = 'Successful'
    msg = 'Build Succeeded'
    health = 95
  else
    status = 'Failed'
    msg = 'ERROR'
    health = 5
  end
  if jobname.length > 18
    name1 = jobname[0...18]
    name2 = jobname[18...36]
    Dashing.send_event(widgetId, {updated: "Last updated at "+Time.current.strftime("%H:%M"), bigName: name2, name: name1, status: status, tc: 1, health: health, msg: msg, urlLink: "https://teamcity.coupadev.com/project.html?projectId="+jobname})
    Rails.application.config.GLOBAL_CACHE[widgetId]["urlLink"]="https://teamcity.coupadev.com/project.html?projectId="+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["name"]='Teamcity '+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["status"]=status
    Rails.application.config.GLOBAL_CACHE[widgetId]["health"]=health
    Rails.application.config.GLOBAL_CACHE[widgetId]["msg"]=msg
    Rails.application.config.GLOBAL_CACHE[widgetId]["updated"]="Last updated at "+Time.current.strftime("%H:%M")
  else
    Dashing.send_event(widgetId, {updated: "Last updated at "+Time.current.strftime("%H:%M"), name: 'Teamcity '+jobname, status: status, tc: 1, health: health, msg: msg, urlLink: "https://teamcity.coupadev.com/project.html?projectId="+jobname})
    Rails.application.config.GLOBAL_CACHE[widgetId]["urlLink"]="https://teamcity.coupadev.com/project.html?projectId="+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["name"]='Teamcity '+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["status"]=status
    Rails.application.config.GLOBAL_CACHE[widgetId]["health"]=health
    Rails.application.config.GLOBAL_CACHE[widgetId]["msg"]=msg
    Rails.application.config.GLOBAL_CACHE[widgetId]["updated"]="Last updated at "+Time.current.strftime("%H:%M")
  end
end


Dashing.scheduler.every '10m', :first_in => 6, allow_overlapping: false do |job|
  if Rails.application.config.all_widgets
		Rails.application.config.all_widgets.each do |c|
	   		if c.widget_typeid == 9
  			    status=TeamCityHelper.getJobStatus(c.jobname)
  			    if status == 'SUCCESS'
  			      color = :green
  			    else
  			      color = :red
  			    end
  			    updateTCWidget(c.id, c.jobname, color)
			end
		end
  end

end



