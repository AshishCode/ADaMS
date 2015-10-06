class TimesheetController < ApplicationController
	respond_to :html, :json

	#method to fetch all the timesheet entries on the basis of form and default
	def index

		#creating array of the ids in case the input value is "all"
		if params[:employee_id] == '0'
			params[:employee_id] = User.pluck(:id)
		else
		end
		if params[:client_id] == '0'
			params[:client_id] = Client.pluck(:id)
		else
		end
		if params[:project_id] == '0'
			params[:project_id] = Project.pluck(:id)
		else
		end

		#filter parameters
		if (params.has_key?(:start_date) && params.has_key?(:end_date))
			
			if params[:end_date]>params[:start_date]
				if params.has_key?(:is_billed)
					@timesheet = Timesheet.where(:employee_id => params[:employee_id], :client_id => params[:client_id], :project_id => params[:project_id], :is_billed =>  params[:is_billed]).where("timesheetdate BETWEEN ? AND ?", params[:start_date], params[:end_date])
				else
					@timesheet = Timesheet.where(:employee_id => params[:employee_id], :client_id => params[:client_id], :project_id => params[:project_id]).where("timesheetdate BETWEEN ? AND ?", params[:start_date], params[:end_date])
				end
			else
				@timesheet = Timesheet.where("timesheetdate BETWEEN CURRENT_DATE -30 AND CURRENT_DATE")	
			end
		else
			@timesheet = Timesheet.where("timesheetdate BETWEEN CURRENT_DATE -30 AND CURRENT_DATE")
		end

		@users  = User.all
		@client = Client.all
		@project = Project.all
		@rolez = Role.all
  	end

  	#method to return the timesheet of a particular employee
  	def my_index
  		
  		if current_user.id != params[:employee_id]
  			params[:employee_id] = current_user.id
  		else
  		end
  		#for inline editing part
  		if (params.has_key?(:start_date) && params.has_key?(:end_date))

  			if params[:end_date]>params[:start_date]
  				@timesheet = Timesheet.where("employee_id = ? AND timesheetdate BETWEEN ? AND ? ", params[:employee_id],params[:start_date], params[:end_date])
  			else
  			end
  		else
  			@timesheet = Timesheet.where("employee_id = ? AND timesheetdate BETWEEN CURRENT_DATE - INTERVAL '7 days' AND CURRENT_DATE", params[:employee_id])
  		end
  		@roles = Role.all.map{|x| [x.id, x.role_name]}
  		@workspace = [["Home","Home"],["Office","Office"],["Clientsite","Clientsite"]]
  		@is_billed = [["true","Yes"],["false","No"]]
  		@clients = Client.all.map {|x| [x.id, x.client_name]}
  		@projects = Project.all.map {|x| [x.id, x.project_code]}

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

	#method to cascade the project names as per the clients
	#used the partial method here hence the response is in the form of script
	def update_project
		@client_select = params[:client_id]
		@clients = Client.where("id = ?", @client_select)
		@projects = Project.where("client_id = ?",@clients[0][:id]).all
		
		render :json => @projects.map {|p| [p.id, p.project_code]}
		#respond_to do |format|
      	#	format.js
    	#end
    	#respond_to do |format|
    	#	msg = { :status => @projects, :message => "Success!", :html => "<b></b>" }
    	#	format.json  { render :json => msg } # don't do msg.to_json
  		#end
	end

	#method to cascade the role names as per the projects
	#simple ajax response
	def update_role
		@project_select = params[:project_id]
		@project_id = Project.where("id = ?", @project_select)
		@roles = Role.where("project_id = ?", @project_id[0][:id]).all

		# render an array in JSON containing arrays like:
    	render :json => @roles.map{|c| [c.id, c.role_name]}
	end

	#method to cascade the rates as per the role
	def update_rate
		@role_select = params[:role_id]
		@rate = Role.where("id = ?", @role_select).all
		
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
		if (params[:timesheets][:timesheetdate] != params[:date][:range])
			
			start_date = params[:timesheets][:timesheetdate]
			end_date = params[:date][:range] 
			start_date.upto(end_date) do |date|

				params[:timesheets][:timesheetdate] = date
				@timesheet = Timesheet.new(timesheets_params)
				if @timesheet.save
					#render :json => @timesheet			
				else
					render 'new'
				end
			end
			redirect_to '/timesheet/'+current_user.id.to_s
		else
			@timesheet = Timesheet.new(timesheets_params)
			if @timesheet.save
				redirect_to '/timesheet/'+current_user.id.to_s
				#render :json => @timesheet			
			else
				render 'new'
			end
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
		      format.html { redirect_to(@timesheet, :notice => 'Entry was successfully updated.') }
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
			redirect_to "/timesheet/"+ current_user.id.to_s
		else
			reder :action => "delete"
		end
	end

	#this private method is used to permit the form parameters and make them
	#accessible to the class
	private 
	#parameters for update
	def timesheet_params
		params.require(:timesheet).permit(:client,:project,:task,:timesheetdate,:hours,:role,:rate,:is_billed,:workspace,:comments, 
		:employee_id)
	end

	#parameters for insertion
	private 
	def timesheets_params
		params.require(:timesheets).permit(:client_id,:project_id,:task,:timesheetdate,:hours,:role_id,:rate,:is_billed,:workspace,:comments, 
		:employee_id)
	end
end
