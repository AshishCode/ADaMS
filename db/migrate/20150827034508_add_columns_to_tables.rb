class AddColumnsToTables < ActiveRecord::Migration
  def change
  	create_table :currency do |c|
  		c.string :currency_name
  		c.string :currency_symbol
  		c.string :country
  		c.text :description
      c.timestamps null: false
  	end

  	add_column :clients, :Address, :text
  	add_column :projects, :project_description, :text
  	add_column :projects, :contact_person, :string
  	add_column :projects, :contact_phone, :integer
  	add_column :projects, :contact_mail, :string
  	add_column :roles, :role_description, :text
  	add_column :roles, :currency_id, :integer
  end
end