FactoryGirl.define do
  factory :department do
    is_deleted false
    name { Faker::Company.name }
  end
end