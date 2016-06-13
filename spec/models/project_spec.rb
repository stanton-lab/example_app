require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many(:project_clients) }
  it { should have_one(:avatar) }
  it { should have_many(:comments) }
  it { should have_many(:clients).through(:project_clients) }

  it 'have valid factory' do
    project = build(:project)
    expect(project).to be_valid
  end

  it 'have scoupe vith is_deleted: false' do
    project = create(:project, is_deleted: true)
    project2 = create(:project, is_deleted: false)
    project3 = create(:project, is_deleted: false)

    expect(Project.real).to include project2
    expect(Project.real).to include project3
    expect(Project.real).to_not include project
  end

  it 'destroy project' do
    project = create(:project, is_deleted: false)

    expect{project.destroy!}.to change{project.is_deleted}.from(false).to(true)
  end
end
