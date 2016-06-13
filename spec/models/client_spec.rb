require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should have_many(:contact_people) }
  it { should have_one(:avatar) }

  it 'have valid factory' do
    client = build(:client)
    expect(client).to be_valid
  end

  it 'have scope with is_deleted: false' do
    client = create(:client, is_deleted: true)
    client2 = create(:client, is_deleted: false)
    client3 = create(:client, is_deleted: false)

    expect(Client.real).to include client2
    expect(Client.real).to include client3
    expect(Client.real).to_not include client
  end

  it 'have scope with order created_at: desc' do
    client = create(:client)
    client2 = create(:client)
    client3 = create(:client)

    expect(Client.ordered.first).to eq client3
    expect(Client.ordered.last).to eq client
  end

  it 'destroy client' do
    client = create(:client, is_deleted: false)

    expect{ client.delete! }.to change{ client.is_deleted }.from(false).to(true)
  end
end
