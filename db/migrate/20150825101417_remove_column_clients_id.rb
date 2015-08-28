class RemoveColumnClientsId < ActiveRecord::Migration
  def change
  	remove_column :projects, :clients_id
  end
end
