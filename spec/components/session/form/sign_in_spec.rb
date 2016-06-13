require 'rails_helper'

describe Session::Form::SignIn do
  it 'will be valid' do
    manager = create(:manager)
    form = described_class.new(email: manager.email,
                               password: manager.password)
    expect(form.valid?).to be_truthy
  end

  it 'will be not valid' do
    form = described_class.new(email: '')
    expect(form.valid?).to_not be_truthy
  end
end