class Project < ActiveRecord::Base
	belongs_to :clients
	has_many :roles
	has_many :timehseets
end
