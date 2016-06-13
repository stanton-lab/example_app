# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_deleted :boolean          default(FALSE)
#

class Department < ActiveRecord::Base
  has_many :works

  scope :real, -> { where(is_deleted: false) }

  def delete!
    update_attribute :is_deleted, true
  end
end
