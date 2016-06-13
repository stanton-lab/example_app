class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commentable, polymorphic: true, index: true
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
