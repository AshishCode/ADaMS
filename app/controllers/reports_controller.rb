class ReportsController < ApplicationController

	#action for the various reports
	def index
		#@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month, role_id, rate, is_billed, employee_id").group("client_id, project_id,month, role_id, rate, is_billed, employee_id").where("timesheetdate BETWEEN CURRENT_DATE-30 AND CURRENT_DATE").order("client_id,project_id")

		@users  = User.all
		@client = Client.all
		@project = Project.all
		@rolez = Role.all

		if params.has_key?(:report_type) && params.has_key?(:from_date) && params.has_key?(:to_date)
			@to_date = params[:to_date].sub! '?reload', ''
			# @to_date = params[:to_date].split(',')
			# @to_date = @to_date[0]
			@params = @to_date

			@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month, role_id, rate, is_billed, employee_id").group("client_id, project_id, month, role_id, rate, is_billed, employee_id").where("timesheetdate >= ? AND timesheetdate <= ?", params[:from_date], params[:to_date] ).order("client_id,project_id")

		else
			@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month, role_id, rate, is_billed, employee_id").group("client_id, project_id,month, role_id, rate, is_billed, employee_id").where("timesheetdate BETWEEN CURRENT_DATE-30 AND CURRENT_DATE").order("client_id,project_id")
		end

		@currencies = Currency.all
		@currency_names = Hash.new()
		@currencies.each {|cr|
			@currency_names [cr.id] = cr.currency_symbol
		}
	end
end
