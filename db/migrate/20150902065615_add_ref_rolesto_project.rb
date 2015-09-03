class AddRefRolestoProject < ActiveRecord::Migration
  def change
  	add_reference :roles, :projects, index: true, foreign_key: true
  end
end
