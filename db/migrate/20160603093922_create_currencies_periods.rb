class CreateCurrenciesPeriods < ActiveRecord::Migration
  def change
    create_table :currencies_periods do |t|
      t.belongs_to :period, index: true
      t.belongs_to :currency, index: true
      t.decimal :value, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
