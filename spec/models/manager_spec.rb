require 'rails_helper'

RSpec.describe Manager, type: :model do
  it 'will be valid factory' do
    expect{create(:manager)}.to change{Manager.count}.from(0).to(1)
  end

  describe '.login' do
    it 'will find by login case insensitive' do
      manager = create(:manager)
      expect(Manager.login(manager.email.capitalize).count).to eq(1)
    end
  end

  describe '.real' do
    it 'will find not deleted records' do
      create(:manager)
      create(:manager, is_deleted: true)
      expect(Manager.real.count).to eq(1)
    end
  end

  describe '#delete!' do
    it 'will mark record as delete' do
      manager = create(:manager)
      manager.delete!
      expect(manager.reload.is_deleted).to be_truthy
    end
  end
end
