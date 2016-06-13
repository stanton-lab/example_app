class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :default, precision: 8, scale: 2
      t.boolean :is_active, default: false

      t.timestamps null: false
    end
  end
end

