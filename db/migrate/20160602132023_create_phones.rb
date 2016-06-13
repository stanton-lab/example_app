class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.integer :phonable_id, index: true
      t.string :phonable_type

      t.timestamps null: false
    end
  end
end
