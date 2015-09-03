class RemoveRefRolePRoject < ActiveRecord::Migration
  def change
  	remove_column :projects, :role_id
  	add_column :roles, :project_id, :integer
  end
end
