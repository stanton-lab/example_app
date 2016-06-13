class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :is_deleted, default: false
      t.boolean :is_active, default: true

      t.timestamps null: false
    end

    create_table :project_clients do |t|
      t.belongs_to :project, index: true
      t.belongs_to :client, index: true

      t.timestamps null: false
    end
  end
end