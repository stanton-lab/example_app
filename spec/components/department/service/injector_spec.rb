require 'rails_helper'

describe Department::Service::Injector do
  include Department::Service::Injector

  describe '#create_service' do
    it 'will build correct create service' do
      service = create_service(create(:manager))
      expect(service).to be_instance_of(Department::Service::Create)
      expect(service.form).to be_instance_of(Department::Form::Create)
    end
  end

  describe '#update_service' do
    it 'will build correct update service' do
      department = create(:department)
      service    = update_service(create(:manager), department.id)
      expect(service).to be_instance_of(Department::Service::Update)
      expect(service.form).to be_instance_of(Department::Form::Update)
    end

    it 'will find correct department record' do
      department = create(:department)
      service    = update_service(create(:manager), department.id)
      expect(service.model).to eq(department)
    end
  end
end