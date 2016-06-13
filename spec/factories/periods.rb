FactoryGirl.define do
  factory :period do

    starts_at { Faker::Date.forward(2) }
    ends_at { Faker::Date.backward(2) }

    after(:build) do |period|

      period.currencies << create(:currency)
      period.currencies_periods.each do |cp|
        cp.value = 33
      end
    end

  end
end