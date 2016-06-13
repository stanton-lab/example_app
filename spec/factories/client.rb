FactoryGirl.define do
  factory :client do
    company { Faker::Company.name }
    association :avatar, factory: :avatar
    is_deleted false

    factory :client_attributes do
      contact_people { attributes_for_list(:contact_person_attributes, 2) }
    end

    after(:create) do |client|
      create_list(:contact_person, 3, client: client)
    end
  end
end