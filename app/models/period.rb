# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  starts_at  :date
#  ends_at    :date
#  is_deleted :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Period < ActiveRecord::Base
  has_many :currencies, through: :currencies_periods
  has_many :currencies_periods

  accepts_nested_attributes_for :currencies_periods

  scope :real, -> { where(is_deleted: false) }

  validates :starts_at, :ends_at,
            overlap: { query_options:   { real: nil },
                       message_title:   :starts_at,
                       message_content: 'выбранный диапазон пересекается с существующим' }

  validates :starts_at, :ends_at, presence: true
end
