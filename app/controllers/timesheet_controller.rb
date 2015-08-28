class TimesheetController < ApplicationController
	respond_to :html, :json

	#method to fetch all the timesheet entries
	def index
		@timesheet = Timesheet.all
		@users  = User.all
  	end

  	#method to return the timesheet of a particular employee
  	def my_index
  		@timesheet = Timesheet.where(:employee_id => params[:employee_id])
  		@roles = Role.all.map{|x| [x.role_name, x.role_name]}
  		@workspace = [["Home","Home"],["Office","Office"],["Clientsite","Clientsite"]];

  		#for the insertion part
  		@timesheets = Timesheet.new
		@client = Client.all
		@project = Project.all
		@rolez = Role.all

  	end

  	#method to create a new timesheet object for the form
	def new
		@timesheet = Timesheet.new
		@client = Client.all
		@project = Project.all
		@roles = Role.all
	end	

	#method to update the project names as per the clients
	def update_project
		@client_select = params[:client_name]
		@clients = Client.where("client_name = ?", @client_select)
		@projects = Project.where("client_id = ?",@clients[0][:id]).all
		
		respond_to do |format|
      		format.js
    	end
    	#respond_to do |format|
    	#	msg = { :status => @projects, :message => "Success!", :html => "<b></b>" }
    	#	format.json  { render :json => msg } # don't do msg.to_json
  		#end
	end

	#method to update the project names as per the clients
	def update_rate
		@role_select = params[:role_name]
		@rate = Role.where("role_name = ?", @role_select).all
		
		# render an array in JSON containing arrays like:
    	render :json => @rate[0]['rate']
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

	#method to create a new timesheet entry inline
	def create_inline
		@timesheet = Timesheet.new(timesheets_params)
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
		params.require(:timesheet).permit(:client,:project,:task,:timesheetdate,:hours,:role,:rate,:is_billed,:workspace,:comments, 
		:employee_id)
	end

	private 
	def timesheets_params
		params.require(:timesheets).permit(:client,:project,:task,:timesheetdate,:hours,:role,:rate,:is_billed,:workspace,:comments, 
		:employee_id)
	end
end
