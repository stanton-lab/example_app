# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  phone         :string
#  phonable_id   :integer
#  phonable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_phones_on_phonable_id  (phonable_id)
#

class Phone < ActiveRecord::Base
  belongs_to :phonable, polymorphic: true
end
