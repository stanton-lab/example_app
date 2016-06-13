FactoryGirl.define do
  factory :contact_person do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    association :avatar, factory: :avatar
    is_deleted false
    client

    factory :contact_person_attributes do
      phones { attributes_for_list(:phone, 2) }
    end

    after(:create) do |person|
      person.phones << create_list(:phone, 2)
    end
  end
end