class TimesheetController < ApplicationController
  def index
	@timesheet = Timesheet.all
  end

	def new
		@timesheet = Timesheet.new	
	end	
	
	def create
		@timesheet = Timesheet.new(timesheet_params)
		if @timesheet.save
			redirect_to '/timesheet'
		else
			render 'new'
		end
	end

	private 
	def timesheet_params
		params.require(:timesheet).permit(:client,:project,:task,:timesheetdate,:hours,:is_billed,:at_home,:at_clientsite,:comments, 
		:employee_id)
	end
end
