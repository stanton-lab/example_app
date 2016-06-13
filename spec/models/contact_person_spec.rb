require 'rails_helper'

RSpec.describe ContactPerson, type: :model do
  it { should belong_to(:client) }
  it { should have_one(:avatar) }

  it 'destroy contact_person' do
    contact_person = create(:contact_person, is_deleted: false)

    expect{contact_person.destroy!}.to change{contact_person.is_deleted}.from(false).to(true)
  end
end
