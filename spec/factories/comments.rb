FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    is_deleted false
  end
end