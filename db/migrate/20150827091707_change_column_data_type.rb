class ChangeColumnDataType < ActiveRecord::Migration
  def change
  	remove_column :projects, :contact_phone
  	add_column :projects, :contact_phone, :string
  end
end
