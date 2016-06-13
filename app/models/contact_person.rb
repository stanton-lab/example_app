# == Schema Information
#
# Table name: contact_people
#
#  id         :integer          not null, primary key
#  email      :string           default(""), not null
#  full_name  :string           default(""), not null
#  phones     :text             is an Array
#  client_id  :integer
#  is_deleted :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contact_people_on_client_id  (client_id)
#

class ContactPerson < ActiveRecord::Base
  belongs_to :client
  has_one :avatar, as: :avatarable
  has_many :phones, as: :phonable

  def destroy!
    update_attributes(is_deleted: true)
  end
end
