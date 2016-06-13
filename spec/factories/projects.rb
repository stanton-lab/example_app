FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    is_deleted false
    association :avatar, factory: :avatar
    association :manager, factory: :manager

    after(:build) do |project|
      project.clients << create(:client)

    end

    after(:create) do |project|
      project.comments = create_list(:comment, 3, commentable: project)
    end

    factory :project_attributes do
      manager_id { create(:manager).id }
      clients { create_list(:client, 2).map(&:id) }
    end
  end
end