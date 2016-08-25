class Widget < AppsWebserver
	belongs_to :dashboard
	validates_presence_of :title
	validates_presence_of :dashboard_id
end
