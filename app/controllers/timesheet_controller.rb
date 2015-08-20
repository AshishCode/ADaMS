class TimesheetController < ApplicationController
	respond_to :html, :json

	#method to fetch all the timesheet entries
	def index
		@timesheet = Timesheet.all
  	end

  	#method to create a new timesheet object for the form
	def new
		@timesheet = Timesheet.new	
	end	
	
	#method to create a new timesheet entry
	def create
		@timesheet = Timesheet.new(timesheet_params)
		if @timesheet.save
			redirect_to '/timesheet'
		else
			render 'new'
		end
	end

	#method to create a new timesheet object for the edit setup
	def edit
		@timesheet = Timesheet.find(params[:id])
	end

	#method to update the timesheet entries
	def update
		@timesheet = Timesheet.find(params[:id])
		
		#@timesheet.update_attributes(timesheet_params)
		#respond_with @timesheet, notice: "Done!"
		#redirect_to "/timesheet", notice: "updated!" 
		
	 	respond_to do |format|
		    if @timesheet.update_attributes(timesheet_params)
		      format.html { redirect_to(@user, :notice => 'Entry was successfully updated.') }
		      format.json { respond_with_bip(@timesheet) }
		    else
		      format.html { render :action => "edit" }
		      format.json { respond_with_bip(@timesheet) }
		    end

  	    end
	end

	#method to delete a timesheet entry
	def delete
		@timesheet = Timesheet.find(params[:id])

		if @timesheet.destroy
			redirect_to "/timesheet"
		else
			reder :action => "delete"
		end
	end

	#this private method is used to permit the form parameters and make them
	#accessible to the class
	private 
	def timesheet_params
		params.require(:timesheet).permit(:client,:project,:task,:timesheetdate,:hours,:is_billed,:at_home,:at_clientsite,:comments, 
		:employee_id)
	end
end
