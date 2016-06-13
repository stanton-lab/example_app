require 'rails_helper'

RSpec.describe Work, type: :model do
  it { should belong_to(:department) }

  it 'have valid factory' do
    work = build(:work)
    expect(work).to be_valid
  end

  it 'have validation on name' do
    work = build(:work, name: nil)
    expect(work).to_not be_valid
  end

  it 'have validation on department' do
    work = build(:work, department_id: nil)
    expect(work).to_not be_valid
  end

  it 'have validation on percent' do
    work = build(:work, percent: 101)
    expect(work).to_not be_valid
  end
  it 'have validation on percent' do
    work = build(:work, percent: 0)
    expect(work).to_not be_valid
  end

  it 'have scoupe vith is_deleted: false' do
    work = create(:work, is_deleted: true)
    work2 = create(:work, is_deleted: false)
    work3 = create(:work, is_deleted: false)

    expect(Work.real).to include work2
    expect(Work.real).to include work3
    expect(Work.real).to_not include work
  end

  it 'destroy client' do
    work = create(:work, is_deleted: false)

    expect{work.destroy!}.to change{work.is_deleted}.from(false).to(true)
  end
end
