require 'eat'
require 'nokogiri'
require 'yaml'
require 'solano_helper'

def updateSolanoWidget(widgetId, name, jobStatus)
  activity = jobStatus['activity']
  lastBuildStatus = jobStatus['lastBuildStatus']

  if activity == "Sleeping" && lastBuildStatus == "Success" then
    status = 'Successful'
    health = 95
    msg = 'Activity: Sleeping... Last Build Status: Success'
  elsif activity == "Sleeping" && lastBuildStatus == "Failure" then
    status = 'Failed'
    health = 5
    msg = 'Activity: Sleeping... Last Build Status: Failure'
  elsif activity == "Building" && lastBuildStatus == "Failure" then
    status = 'Failed'
    health = 5
    msg = 'Activity: Building... Last Build Status: Failure'
  elsif activity == "Building" && lastBuildStatus == "Success" then
    status = 'Successful'
    health = 95
    msg = 'Activity: Building... Last Build Status: Success'
  else
    status = 'Failed'
    health = 5
    msg = 'unknown'
  end

  #update the widget
  if name.length > 18 #split the job name if it's too long
    name1 = name[0...18]
    name2 = name[18...36]
    Dashing.send_event(widgetId, {bigName: name2, name: name1, so: 1, status: status, health: health, msg: msg, urlLink: "https://ci.solanolabs.com"})
  else
    Dashing.send_event(widgetId, {name: name, status: status, so: 1, health: health, msg: msg, urlLink: "https://ci.solanolabs.com"})
  end
end


Dashing.scheduler.every '25m', :first_in => 7 do |job|
  if Rails.application.config.all_widgets
		Rails.application.config.all_widgets.each do |c|
	   		if c.widget_typeid == 10
  			    name=c.title
  			    jobname=c.jobname
  			    jobStatus = SolanoHelper.getJobStatus(jobname)

  			  #update the widget
  			  updateSolanoWidget(c.id, name, jobStatus)
      end
		end
  end
end



