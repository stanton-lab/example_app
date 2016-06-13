class AddIsDeletedToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :is_deleted, :boolean, default: false
  end
end
