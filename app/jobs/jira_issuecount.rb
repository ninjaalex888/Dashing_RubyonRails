require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'
require 'yaml'
require 'jira_helper'


Dashing.scheduler.every '31m', :first_in => 10, allow_overlapping: false do
  if Rails.application.config.all_widgets
  	Rails.application.config.all_widgets.each do |c|
  	   	if c.widget_typeid == 1
    		    total = JiraHelper.getNumberOfIssues(c.jql)
    		    Dashing.send_event(c.id, {current: total})
            Rails.application.config.GLOBAL_CACHE[c.id]["total"]=total
            Rails.application.config.GLOBAL_CACHE[c.id]["updated"]="Last updated at "+Time.current.strftime("%H:%M")
            Rails.application.config.GLOBAL_CACHE[c.id]["urlLink"]="https://coupadev.atlassian.net/issues/?jql="+c.jql
  		end
  	end

  end

end


