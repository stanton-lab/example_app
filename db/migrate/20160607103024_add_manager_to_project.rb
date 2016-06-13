class AddManagerToProject < ActiveRecord::Migration
  def change
    add_column :projects, :manager_id, :integer, index: true
  end
end
