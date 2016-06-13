class AddManagerToComment < ActiveRecord::Migration
  def change
    add_column :comments, :manager_id, :integer, index: true
  end
end
