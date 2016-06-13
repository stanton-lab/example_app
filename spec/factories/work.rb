FactoryGirl.define do
  factory :work do
    name { Faker::Company.name }
    is_iterative false
    percent 11
    department
  end
end