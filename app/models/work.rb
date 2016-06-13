# == Schema Information
#
# Table name: works
#
#  id            :integer          not null, primary key
#  name          :string
#  department_id :integer
#  is_iterative  :boolean          default(FALSE)
#  is_deleted    :boolean          default(FALSE)
#  percent       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_works_on_department_id  (department_id)
#

class Work < ActiveRecord::Base
  belongs_to :department

  scope :real, -> { where(is_deleted: false) }

  validates :name, :department, presence: true

  validates_numericality_of :percent,
                            only_integer:   true,
                            allow_nil:      true,
                            greater_than_or_equal_to: 0.01,
                            less_than_or_equal_to: 100,
                            message: 'Может быть в пределах от 0.01 до 100%.'

  def destroy!
    update_attributes(is_deleted: true)
  end
end
