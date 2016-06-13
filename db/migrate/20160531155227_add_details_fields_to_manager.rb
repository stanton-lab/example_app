class AddDetailsFieldsToManager < ActiveRecord::Migration
  def change
    add_column :managers, :full_name, :string
    add_column :managers, :first_name, :string
    add_column :managers, :last_name, :string
    add_column :managers, :birthday, :datetime
    add_column :managers, :worked_at, :datetime
    add_column :managers, :skype, :string
    add_column :managers, :department_id, :integer, index: true
    add_column :managers, :status, :integer, default: 0
  end
end
