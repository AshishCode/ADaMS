class Project < ActiveRecord::Base
	belongs_to :clients
	belongs_to :roles
end
