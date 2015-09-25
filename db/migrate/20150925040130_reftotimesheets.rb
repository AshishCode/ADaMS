class Reftotimesheets < ActiveRecord::Migration
  def change
  	add_column :timesheets, :project_id, :integer
  	add_column :timesheets, :client_id, :integer
  	add_column :timesheets, :role_id, :integer
  	add_reference :timesheets, :projects, index: true, foreign_key: true
  	add_reference :timesheets, :clients, index: true, foreign_key: true
  	add_reference :timesheets, :roles, index: true, foreign_key: true
  end
end
