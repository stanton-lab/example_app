require 'rails_helper'

describe Avatar::Form::Create do
  it 'will be valid' do
    form = described_class.new(Avatar.new)
    expect(form.validate(attributes_for(:avatar)))
      .to be_truthy
  end

  it 'will be not valid if image is not present' do
    form = described_class.new(Avatar.new)
    expect(form.validate(attributes_for(:avatar_invalid)))
      .to be_falsey
  end
end