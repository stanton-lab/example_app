class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :starts_at
      t.date :ends_at
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
