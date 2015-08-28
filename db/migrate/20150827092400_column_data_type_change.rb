class ColumnDataTypeChange < ActiveRecord::Migration
  def change
  	remove_column :projects, :contact_phone
  	add_column :projects, :contact_phone, :bigint
  end
end
