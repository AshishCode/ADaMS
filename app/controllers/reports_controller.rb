class ReportsController < ApplicationController

	#action for the various reports
	def index
		@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS Total_hours, role_id, rate, is_billed, employee_id").group("client_id, project_id, role_id, rate, is_billed, employee_id").where("timesheetdate BETWEEN CURRENT_DATE-30 AND CURRENT_DATE").order("client_id,project_id")

		@users  = User.all
		@client = Client.all
		@project = Project.all
		@rolez = Role.all

		@currencies = Currency.all
		@currency_names = Hash.new()
		@currencies.each {|cr|
			@currency_names [cr.id] = cr.currency_symbol
		}
	end
end
