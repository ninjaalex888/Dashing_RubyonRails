require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'
require 'yaml'
require 'jira_helper'



Dashing.scheduler.every '3h', :first_in => 3, allow_overlapping: false do


  	if Rails.application.config.all_widgets
		Rails.application.config.all_widgets.each do |c|
			if c.widget_typeid == 5
				sprint = c.jql
			    hrows = [
			    			{ cols: [ {value:'Components'},{value: 'Open'}, {value: 'Reopened'}, {value: 'In Progress'}, {value: 'Code Review'},{value: 'Code Propagation'}, {value:'Ready to Merge'}, {value: 'Resolved'}, {value: 'Closed'}] }
			  	]
			  	rows = []
			    rows = Rails.application.config.GLOBAL_CACHE[c.id]["rows"]
			  	
			    Dashing.send_event(c.id, { hrows: hrows, rows: rows } )
	          	Rails.application.config.GLOBAL_CACHE[c.id]["urlLink"]="https://coupadev.atlassian.net/issues/?jql="+c.jql
			    Rails.application.config.GLOBAL_CACHE[c.id]["hrows"]=hrows
			    Rails.application.config.GLOBAL_CACHE[c.id]["rows"]=rows
			    Rails.application.config.GLOBAL_CACHE[c.id]["updated"]="Last updated at "+Time.new.strftime("%H:%M") 
				
			end
		end
	end



end