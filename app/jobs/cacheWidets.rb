Dashing.scheduler.every '40s', :first_in => 0, allow_overlapping: false do

	Rails.application.config.all_widgets = Widget.all

end