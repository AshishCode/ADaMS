class AddCurrencyRefToRoles < ActiveRecord::Migration
  def change
  	  	remove_column :roles, :currency_id
  	  	#add_reference :roles, :currency, index: true, foreign_key: true
  end
end
