class AddIsDeleted < ActiveRecord::Migration
  def change
    add_column :clients, :is_deleted, :boolean, default: false
  end
end
