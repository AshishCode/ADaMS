class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
		t.string :currency_name
		t.string :currency_symbol
		t.string :country
		t.text :description
      t.timestamps null: false
    end
  end
end
