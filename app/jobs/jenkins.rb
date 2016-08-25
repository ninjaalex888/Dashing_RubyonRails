require 'net/http'
require 'json'
require 'yaml'
require 'uri'
require 'jenkins_helper'


def updateJenkinsWidget(widgetId, jobname, color)
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
    Dashing.send_event(widgetId, {updated: "Last updated at "+Time.current.strftime("%H:%M"), bigName: name2, name: name1, status: status, jk: 1, health: health, msg: msg, urlLink: "https://jenkins.coupadev.com/job/"+jobname})
  else
    Dashing.send_event(widgetId, {updated: "Last updated at "+Time.current.strftime("%H:%M"), name: 'Jenkins '+jobname, status: status, jk: 1, health: health, msg: msg, urlLink: "https://jenkins.coupadev.com/job/"+jobname})
    Rails.application.config.GLOBAL_CACHE[widgetId]["urlLink"]="https://jenkins.coupadev.com/job/"+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["name"]='Jenkins '+jobname
    Rails.application.config.GLOBAL_CACHE[widgetId]["status"]=status
    Rails.application.config.GLOBAL_CACHE[widgetId]["health"]=health
    Rails.application.config.GLOBAL_CACHE[widgetId]["msg"]=msg
    Rails.application.config.GLOBAL_CACHE[widgetId]["updated"]="Last updated at "+Time.current.strftime("%H:%M")
  end
end

Dashing.scheduler.every '12m', :first_in => 5, allow_overlapping: false do |job|
  if Rails.application.config.all_widgets
    count = 1
	  Rails.application.config.all_widgets.each do |c|
	    if c.widget_typeid == 11
          count = count + 1
          updateJenkinsWidget(c.id, c.jobname, JenkinsHelper.getJobStatus(c.jobname))
      end
	  end
  end

end
