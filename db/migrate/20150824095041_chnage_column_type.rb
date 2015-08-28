class ChnageColumnType < ActiveRecord::Migration
  def change
  	change_table :timesheets do |t|
  		t.change :is_billed, :boolean
  		t.change :at_home, :boolean
  		t.change :at_clientsite, :boolean
  	end
  end
end
