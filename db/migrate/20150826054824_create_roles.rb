class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.float :rate
      t.timestamps null: false
    end

    add_column :timesheets, :role, :string
    add_column :timesheets, :rate, :float
  end
end
