class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company, null: false, default: ""

      t.timestamps null: false
    end
  end
end
