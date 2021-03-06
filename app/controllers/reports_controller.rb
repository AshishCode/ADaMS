class ReportsController < ApplicationController

	#action for the various reports
	def index
		#@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month, role_id, rate, is_billed, employee_id").group("client_id, project_id,month, role_id, rate, is_billed, employee_id").where("timesheetdate BETWEEN CURRENT_DATE-30 AND CURRENT_DATE").order("client_id,project_id")

		@users  = User.all
		@client = Client.all
		@project = Project.all
		@rolez = Role.all

		if (params.has_key?(:report_type) && params.has_key?(:from_date) && params.has_key?(:to_date)) || (params.has_key?(:is_billed))
			@to_date = params[:to_date].sub! '?reload', ''
			# @to_date = params[:to_date].split(',')
			# @to_date = @to_date[0]
			@params = @to_date
			
			if params.has_key?(:is_billed)

				@billed = params[:is_billed].sub! '?reload', ''
				@is_billed = @billed

				if params[:report_type] == 'monthly'

					@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month,role_id, rate, is_billed, employee_id").group("client_id, project_id, month, role_id, rate, is_billed, employee_id").where("timesheetdate >= ? AND timesheetdate <= ? AND is_billed = ?", params[:from_date], params[:to_date], @is_billed ).order("client_id,project_id")

				else
					@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month,
				(extract(week from timesheetdate)) as week,
				 role_id, rate, is_billed, employee_id").group("client_id, project_id, month, week, role_id, rate, is_billed, employee_id").where("timesheetdate >= ? AND timesheetdate <= ? AND is_billed = ?", params[:from_date], params[:to_date], @is_billed ).order("client_id,project_id")
				end				

			else

				if params[:report_type] == 'monthly'

					@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month,role_id, rate, is_billed, employee_id").group("client_id, project_id, month, role_id, rate, is_billed, employee_id").where("timesheetdate >= ? AND timesheetdate <= ?", params[:from_date], params[:to_date] ).order("client_id,project_id")

				else

					@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month,
				(extract(week from timesheetdate)) as week,
				 role_id, rate, is_billed, employee_id").group("client_id, project_id, month, week, role_id, rate, is_billed, employee_id").where("timesheetdate >= ? AND timesheetdate <= ?", params[:from_date], params[:to_date] ).order("client_id,project_id")
				end
			end

		else
			@timesheet = Timesheet.select("client_id, project_id, sum(hours) AS total_hours, EXTRACT(Month from timesheetdate) as month, role_id,rate, is_billed, employee_id").group("client_id, project_id,month,role_id, rate, is_billed, employee_id").where("timesheetdate BETWEEN CURRENT_DATE-30 AND CURRENT_DATE").order("client_id,project_id")
		end

		@currencies = Currency.all
		@currency_names = Hash.new()
		@currencies.each {|cr|
			@currency_names [cr.id] = cr.currency_symbol
		}

		#employee weekly report
		if (params.has_key?(:from_date_emp) && params.has_key?(:to_date_emp))
			#removing the extra ?reload from the parameter
			@to_date_emp = params[:to_date_emp].sub! '?reload', ''		

			if(params.has_key?(:is_billed_emp) && @is_billed_emp == "true")
				@is_billed_emp = params[:is_billed_emp].sub! '?reload', ''
				#params[:is_billed_emp] = @is_billed_emp
				@employee_report = Timesheet.select("employee_id, sum(hours), (extract(week from timesheetdate)) as week").group("employee_id, week").where("timesheetdate >= ? AND timesheetdate <= ? AND is_billed = true", params[:from_date_emp], @to_date_emp).order("week")
			elsif (params.has_key?(:is_billed_emp) && @is_billed_emp == "false")
				@employee_report = Timesheet.select("employee_id, sum(hours), (extract(week from timesheetdate)) as week").group("employee_id, week").where("timesheetdate >= ? AND timesheetdate <= ? AND is_billed = false", params[:from_date_emp], @to_date_emp).order("week")
			else				
				@employee_report = Timesheet.select("employee_id, sum(hours), (extract(week from timesheetdate)) as week").group("employee_id, week").where("timesheetdate >= ? AND timesheetdate <= ?", params[:from_date_emp], @to_date_emp ).order("week")
			end
		else

			@employee_report = Timesheet.select("employee_id, sum(hours), (extract(week from timesheetdate)) as week").group("employee_id, week").where("timesheetdate >= (CURRENT_DATE - 7)  AND timesheetdate <= CURRENT_DATE").order("week")

		end

	end

	#this private method is used to permit the form parameters and make them
	#accessible to the class
	# private 
	# def client_params
	# 	params.require(:client_detail).permit(:client_code, :client_name, :client_address)
	# end

end
