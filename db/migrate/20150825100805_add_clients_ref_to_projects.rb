class AddClientsRefToProjects < ActiveRecord::Migration
  def change
  	  	add_reference :projects, :clients, index: true, foreign_key: true
  end
end
