class AddRefToRoles < ActiveRecord::Migration
  def change
  	add_reference :roles, :currencies, index: true, foreign_key: true
  end
end
