require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'
require 'yaml'
require 'jira_helper'

Dashing.scheduler.every '10m', :first_in => 12, allow_overlapping: false do
  if Rails.application.config.all_widgets
	Rails.application.config.all_widgets.each do |c|
   		if c.widget_typeid == 7
  		  	sprint=c.jql
  		  	tickets,unfinished=JiraHelper.synergy(sprint)
  		  	Dashing.send_event(c.id,   { value: (100*(1-(unfinished.to_f/tickets))).to_i})
          Rails.application.config.GLOBAL_CACHE[c.id]["value"]=(100*(1-(unfinished.to_f/tickets))).to_i
          Rails.application.config.GLOBAL_CACHE[c.id]["updated"]="Last updated at "+Time.current.strftime("%H:%M") 
          Rails.application.config.GLOBAL_CACHE[c.id]["urlLink"]="https://coupadev.atlassian.net/issues/?jql="+c.jql 
  	    
    	end
  	end
  end
end