# == Schema Information
#
# Table name: managers
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  is_deleted             :boolean          default(FALSE)
#  full_name              :string
#  first_name             :string
#  last_name              :string
#  birthday               :datetime
#  worked_at              :datetime
#  skype                  :string
#  department_id          :integer
#  status                 :integer          default(0)
#
# Indexes
#
#  index_managers_on_email                 (email) UNIQUE
#  index_managers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Manager < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  rolify

  enum status: Manager::Value::Status.items

  has_many :phones, as: :phonable
  has_one :avatar, as: :avatarable
  belongs_to :department

  scope :real, -> { where(is_deleted: false) }
  scope :login, ->(login) {real.where('lower(email) = :login',
                                      login: login.downcase)}
  scope :ordered, -> { order(created_at: :desc) }

  class << self
    def decorator_class
      Manager::Decorator
    end
  end

  def ability
    Abilities::Manager.new(self) if persisted?
  end

  def delete!
    update_attribute :is_deleted, true
  end
end
