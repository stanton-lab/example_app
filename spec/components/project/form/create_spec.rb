require 'rails_helper'

describe Project::Form::Create do
  it 'will be valid' do
    form = described_class.new(Project.new)
    expect(form.validate(attributes_for(:project_attributes)))
      .to be_truthy
  end

  it 'will be not valid if name is not present' do
    form = described_class.new(Project.new)
    expect(form.validate(attributes_for(:project_attributes, name: nil)))
      .to be_falsey
  end

  it 'will be not valid if clients is not present' do
    form = described_class.new(Project.new)
    expect(form.validate(attributes_for(:project_attributes, clients: nil)))
      .to be_falsey
  end

  it 'will be not valid if manager_id is not present' do
    form = described_class.new(Project.new)
    expect(form.validate(attributes_for(:project_attributes, manager_id: nil)))
      .to be_falsey
  end
end