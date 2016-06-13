FactoryGirl.define do
  factory :manager do
    email { Faker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    association :avatar, factory: :avatar

    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }

    birthday { 27.years.ago }
    worked_at { 4.years.ago }

    skype { Faker::Internet.user_name }

    department

    factory :manager_attributes do
      phones { attributes_for_list(:phone, 2) }
      role { Role::ADMIN }
      department_id { create(:department).id }
    end

    after(:create) {|manager| manager.add_role(Role::ADMIN)}
  end
end