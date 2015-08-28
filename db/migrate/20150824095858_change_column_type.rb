class ChangeColumnType < ActiveRecord::Migration
  def change
  	  	remove_column :timesheets, :is_billed
  	  	add_column :timesheets, :is_billed, :boolean
  	  	remove_column :timesheets, :at_home
  	  	add_column :timesheets, :at_home, :boolean
  	  	remove_column :timesheets, :at_clientsite
  	  	add_column :timesheets, :at_clientsite, :boolean
  end
end
