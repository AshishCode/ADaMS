class Addclientprojectcodes < ActiveRecord::Migration
  def change
  	add_column :clients, :client_code, :string
  	add_column :projects, :project_code, :string
  end
end
