class User < ActiveRecord::Base
    has_many :dashboards
end
