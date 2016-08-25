require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'
require 'yaml'
require 'jira_helper'


Dashing.scheduler.every '50m', :first_in => 2, allow_overlapping: false do

    if Rails.application.config.all_widgets
	    Rails.application.config.all_widgets.each do |c|
	    	if c.widget_typeid == 6
		    	sprint=c.jql
		    	dates,ps, progress,unfinished, tickets=JiraHelper.sprint_burndown(sprint)
	        	points=[dates, ps, progress].transpose().insert(0,['TIME', 'Expected Work Left', 'Work Left'])
		    	Dashing.send_event(c.id,points: [dates, ps, progress].transpose().insert(0,['TIME', 'Expected Work Left', 'Work Left']))
	      		Rails.application.config.GLOBAL_CACHE[c.id]["points"]=points
			    Rails.application.config.GLOBAL_CACHE[c.id]["updated"]="Last updated at "+Time.current.strftime("%H:%M")  
			    Rails.application.config.GLOBAL_CACHE[c.id]["urlLink"]="https://coupadev.atlassian.net/issues/?jql="+c.jql
		    end
	    end
	end
end