MAX_DAYS_OVERDUE = -20
MAX_DAYS_AWAY = 90



Dashing.scheduler.every '4h', :first_in => 15 do |job|
	if Rails.application.config.all_widgets
		Rails.application.config.all_widgets.each do |c|
	   		if c.widget_typeid == 2
				    json = c.timelinedata 
				    jsonparsed=JSON.parse(json)["events"]
				    unless jsonparsed.nil?
				      events=Array.new
				      today=Date.today
				      no_event_today=true
				      
				      jsonparsed.each do |event|
				        days_away=(Date.parse(event["date"])-today).to_i
				        if (days_away>=0) && (days_away<=MAX_DAYS_AWAY)
				          events << {
				            name: event["name"],
				            date: event["date"],
				            background: event["background"]
				          }
				        elsif (days_away<0) && (days_away>=MAX_DAYS_OVERDUE)
				          events << {
				            name: event["name"],
				            date: event["date"],
				            background: event["background"],
				            opacity: 0.5
				          }
				        end
				        no_event_today=false if days_away==0
				      end
				      if no_event_today
				        events << {
				          name: "TODAY",
				          date: today.strftime('%a %d %b %Y'),
				          background: "gold"
				        } 
				      end
				      Dashing.send_event(c.id, {events: events})
	            	Rails.application.config.GLOBAL_CACHE[c.id]["events"]=c.timelinedata.to_s
				    else
				      puts "No events found :("
				    end
				
			end
		end
  	end
end
