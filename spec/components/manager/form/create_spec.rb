require 'rails_helper'

describe Manager::Form::Create do
  it 'will be valid' do
    form = described_class.new(Manager.new)
    expect(form.validate(attributes_for(:manager_attributes)))
      .to be_truthy
  end
end