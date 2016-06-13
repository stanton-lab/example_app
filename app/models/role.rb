# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_roles_on_name                                    (name)
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#

class Role < ActiveRecord::Base
  ADMIN = :admin

  scopify

  has_and_belongs_to_many :managers, join_table: :managers_roles

  belongs_to :resource,
             polymorphic: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  class << self
    def list
      {
        'Администратор' => ADMIN
      }
    end
  end
end
