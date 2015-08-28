class AddColumnRoleIdToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :role_id, :integer
  end
end
