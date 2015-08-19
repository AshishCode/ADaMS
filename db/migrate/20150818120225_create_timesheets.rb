class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
	t.text :client
	t.text :project
	t.text :task
	t.datetime :timesheetdate
	t.integer :hours
	t.integer :is_billed
	t.integer :at_home
	t.integer :at_clientsite
	t.text :comments
	t.references :employee
      t.timestamps null: false
    end
  end
end
