class Timesheet < ActiveRecord::Base
	belongs_to :employee
	belongs_to :roles
	belongs_to :projects
	belongs_to :clients
end
