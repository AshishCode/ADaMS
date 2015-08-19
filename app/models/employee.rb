class Employee < ActiveRecord::Base
	has_many :timesheet
end
