class Deletecolumns < ActiveRecord::Migration
  def change
  	remove_column :timesheets, :client
  	remove_column :timesheets, :project
  	remove_column :timesheets, :role
  end
end
