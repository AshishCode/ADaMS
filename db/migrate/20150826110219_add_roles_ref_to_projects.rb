class AddRolesRefToProjects < ActiveRecord::Migration
  def change
  	add_reference :projects, :roles, index: true, foreign_key: true
  end
end
