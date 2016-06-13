require 'rails_helper'

RSpec.describe Phone, type: :model do
  it 'will be valid factory' do
    expect { create(:phone) }.to change { Phone.count }.from(0).to(1)
  end
end
