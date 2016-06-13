require 'rails_helper'

describe Client::Form::Create do
  it 'will be valid' do
    form = described_class.new(Client.new)
    expect(form.validate(attributes_for(:client_attributes)))
      .to be_truthy
  end

  it 'will be not valid if contact persons is not present' do
    form = described_class.new(Client.new)
    expect(form.validate(attributes_for(:client_attributes, contact_people: nil)))
      .to be_falsey
  end

  it 'will be not valid if company is not present' do
    form = described_class.new(Client.new)
    expect(form.validate(attributes_for(:client_attributes, company: nil)))
      .to be_falsey
  end
end