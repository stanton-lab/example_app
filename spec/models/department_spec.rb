require 'rails_helper'

RSpec.describe Department, type: :model do
  it { expect(create(:department).persisted?).to be_truthy }

  describe '.real' do
    it 'will find not deleted records' do
      create(:department)
      create(:department, is_deleted: true)
      expect(Department.real.count).to eq(1)
    end
  end

  describe '#delete!' do
    it 'will mark record as delete' do
      department = create(:department)
      department.delete!
      expect(department.reload.is_deleted).to be_truthy
    end
  end
end
