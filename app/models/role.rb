class Role < ActiveRecord::Base
	belongs_to :projects
	belongs_to :currencies
	has_many :timesheets
end
