# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  company    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_deleted :boolean          default(FALSE)
#

class Client < ActiveRecord::Base
  has_many :contact_people
  has_one :avatar, as: :avatarable
  has_many :projects, through: :project_clients

  scope :real, -> { where(is_deleted: false) }
  scope :ordered, -> { order(created_at: :desc) }

  class << self
    def decorator_class
      Project::Decorator
    end
  end

  def delete!
    update_attributes(is_deleted: true)
  end
end
