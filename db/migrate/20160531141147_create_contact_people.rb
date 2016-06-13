class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.string :email,      null: false, default: ""
      t.string :full_name,  null: false, default: ""
      t.text :phones,       array: true, dafault: []
      t.references :client, index: true
      t.boolean :is_deleted, null:false, default: false

      t.timestamps null: false
    end
  end
end
