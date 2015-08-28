class AddColumnWorkspace < ActiveRecord::Migration
  def change
  	remove_column :timesheets, :at_home
  	remove_column :timesheets, :at_clientsite
  	add_column :timesheets, :workspace, :string
  end
end
