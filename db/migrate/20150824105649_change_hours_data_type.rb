class ChangeHoursDataType < ActiveRecord::Migration
  def change
  	  remove_column :timesheets, :hours
  	  add_column :timesheets, :hours, :float
  end
end
