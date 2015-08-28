class AddClientsRefTo < ActiveRecord::Migration
  def change
  	#add_column :projects, :client_id, :integer
  	add_reference :projects, :clients, index: true, foreign_key: true
  end
end
