require 'httparty'

github_api = 'https://status.github.com/api/last-message.json'

Dashing.scheduler.every '60m', :first_in => 4 do
	if Rails.application.config.all_widgets
		Rails.application.config.all_widgets.each do |c|
			if c.widget_typeid == 12
  				Dashing.send_event(c.id, HTTParty.get(github_api).parsed_response)
  				
  			end
  		end
  	end



end