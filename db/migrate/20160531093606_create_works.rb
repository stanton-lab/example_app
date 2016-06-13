class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.references :department, index: true
      t.boolean :is_iterative, default: false
      t.boolean :is_deleted, default: false
      t.integer :percent

      t.timestamps null: false
    end
  end
end
