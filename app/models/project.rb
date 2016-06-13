# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  is_deleted :boolean          default(FALSE)
#  is_active  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager_id :integer
#

class Project < ActiveRecord::Base
  has_many :clients, through: :project_clients
  has_many :project_clients
  has_many :comments, as: :commentable

  has_one :avatar, as: :avatarable
  belongs_to :manager

  scope :real, -> { where(is_deleted: false) }
  scope :ordered, -> { order(created_at: :desc) }

  class << self
    def decorator_class
      Project::Decorator
    end
  end

  def destroy!
    update_attributes(is_deleted: true)
  end
end
