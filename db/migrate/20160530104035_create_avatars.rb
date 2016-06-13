class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :image
      t.integer :client_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
