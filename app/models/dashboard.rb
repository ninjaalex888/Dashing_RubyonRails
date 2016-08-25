class Dashboard < AppsWebserver
	has_many :widgets
	belongs_to :user
	validates_presence_of :release
end
