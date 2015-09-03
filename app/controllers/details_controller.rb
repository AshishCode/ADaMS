class DetailsController < ApplicationController
	
	#this is the method which displays all the existing details of clients, projects,roles and currencies
	def index
		#for displaying the data in these tables
		@clients = Client.all
		@projects = Project.all
		@currencies = Currency.all

		#to return the project and client names to show client project relationship
		@client_names = Hash.new()
		@project_names = Hash.new()
		@clients.each { |c|

			@projects.each { |p|

					if(p.client_id == c.id)
						@client_names[c.id] = c.client_name						
						@project_names[c.id] = p.project_name + "," + @project_names[c.id].to_s 											
					end
			}
			@str = @project_names[c.id].to_s
			@str = @str[0...-1]
			@project_names[c.id] = @str
		}

		@roles = Role.all

		#to return the currency symbols for respective roles
		@currency_names = Hash.new()
		@currencies.each {|cr|
			@currency_names [cr.id] = cr.currency_symbol
		}

		#to return the respetive role names and project names for their relation
		@role_project_names = Hash.new();
		@role_names = Hash.new();
		@projects.each { |p|

			@roles.each { |r|

					if(r.project_id == p.id)
						@role_project_names[p.id] = p.project_name
						@role_names[p.id] = r.role_name + "," + @role_names[p.id].to_s
					end					
			}
			@str = @role_names[p.id].to_s
			@str = @str[0...-1]
			@role_names[p.id] = @str

		}

		#for forms
		@client_detail = Client.new
		@project_detail = Project.new
		@role_detail = Role.new 
	end

	#method for adding a new client
	def add_client

		@clients = Client.new(client_params)
		if @clients.save
			redirect_to '/details'
		else
			render 'index'
		end
	end

	#method for adding a new project
	def add_project

		@projects = Project.new(project_params)
		if @projects.save
			redirect_to '/details'
		else
			render 'index'
		end
	end

	#method for adding a new role
	def add_role

		@roles = Role.new(role_params)
		if @roles.save
			redirect_to '/details'
		else
			render 'index'
		end

	end

	#method for adding a new currency
	def add_currency

		@currencies = Currency.new(currency_params)
		if @currencies.save
			redirect_to '/details'
		else
			render 'index'
		end

	end



	#this private method is used to permit the form parameters and make them
	#accessible to the class
	private 
	def client_params
		params.require(:client_detail).permit(:client_name, :client_address)
	end

	private 
	def project_params
		params.require(:project_detail).permit(:project_name,:project_description,:contact_person,:contact_mail,:contact_phone, :client_id)
	end

	private 
	def role_params
		params.require(:role_detail).permit(:role_name, :rate, :currency_id, :role_description, :project_id)
	end

	private 
	def currency_params
		params.require(:currency_detail).permit(:currency_name, :currency_symbol, :country, :description)
	end
end
