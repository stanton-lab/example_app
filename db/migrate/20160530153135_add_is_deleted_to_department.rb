class AddIsDeletedToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :is_deleted, :boolean, default: false
  end
end
