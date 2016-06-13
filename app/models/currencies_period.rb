# == Schema Information
#
# Table name: currencies_periods
#
#  id          :integer          not null, primary key
#  period_id   :integer
#  currency_id :integer
#  value       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_currencies_periods_on_currency_id  (currency_id)
#  index_currencies_periods_on_period_id    (period_id)
#

class CurrenciesPeriod < ActiveRecord::Base
  belongs_to :period
  belongs_to :currency

  validates :value,
            numericality: true,
            presence: true
end
