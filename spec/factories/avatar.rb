FactoryGirl.define do
  factory :avatar do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'photos', 'grey.png'), 'image/png') }

    factory :avatar_invalid do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'photos', 'grey.zip')) }
    end
    factory :avatar_crop_params do
      crop_x 109
      crop_y 0
      crop_w 119
      crop_h 119
    end

    factory :avatar_crop_invalid do
      crop_x nil
      crop_y 0
      crop_w 119
      crop_h 119
    end
  end
end