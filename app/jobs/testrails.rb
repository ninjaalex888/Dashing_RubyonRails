require 'net/http'
require 'yaml'
require 'uri'
require './lib/assets/testrail.rb'
require 'jenkins_api_client'
require 'json'
require 'nokogiri'
require 'testrail_helper'

def updateTestRailWidget(widgetId, status)
  slices=[
        ['Test Type', 'Number Passed'],
        ['Passed',     status['passed']],
        ['Untested',  status['untested']],
        ['Failed', status['failed']]
      ]
  Dashing.send_event(widgetId, slices: [
        ['Test Type', 'Number Passed'],
        ['Passed',     status['passed']],
        ['Untested',  status['untested']],
        ['Failed', status['failed']]
      ])
  Rails.application.config.GLOBAL_CACHE[widgetId]["slices"]=slices
  Rails.application.config.GLOBAL_CACHE[widgetId]["urlLink"]="https://coupa.testrail.com"
end


Dashing.scheduler.every '45m', :first_in => 15, allow_overlapping: false do |job|
  if Rails.application.config.all_widgets
    Rails.application.config.all_widgets.each do |c|
      if c.widget_typeid == 15

        	milestone_id = c.jobname
        	#get the milestone stats
       		status = TestrailHelper.getMilestone(milestone_id)
       		#send the status
          updateTestRailWidget(c.id, status)
      

      end
    end
  end

  
  
end
