require 'rails_helper'

describe Common::Service::Base do
  it 'will have form' do
    form    = Department::Form::Create.new(Department.new)
    service = Common::Service::Base.new(form)
    expect(service.form).to eq(form)
  end

  it 'will delegate #model method to form object' do
    department = Department.new
    service    = Common::Service::Base.new(Department::Form::Create.new(department))
    expect(service.model).to eq(department)
  end
end