# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  name       :string
#  default    :decimal(8, 2)
#  is_active  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Currency < ActiveRecord::Base
  has_many :periods, through: :currencies_periods
  has_many :currencies_periods

  scope :active, -> { where(is_active: true) }

  validates :default,
            format:       { :with => /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than_or_equal_to: 0.01,
                            less_than_or_equal_to: 999999 },
            presence: true

end
