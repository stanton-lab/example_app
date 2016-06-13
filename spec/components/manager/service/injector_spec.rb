require 'rails_helper'

describe Manager::Service::Injector do
  include Manager::Service::Injector

  describe '#create_service' do
    it 'will build correct create service' do
      service = create_service(create(:manager))
      expect(service).to be_instance_of(Manager::Service::Create)
      expect(service.form).to be_instance_of(Manager::Form::Create)
    end
  end

  describe '#update_service' do
    it 'will build correct update service' do
      manager = create(:manager)
      service = update_service(create(:manager), manager.id)
      expect(service).to be_instance_of(Manager::Service::Update)
      expect(service.form).to be_instance_of(Manager::Form::Update)
    end

    it 'will find correct manager record' do
      manager = create(:manager)
      service    = update_service(create(:manager), manager.id)
      expect(service.model).to eq(manager)
    end
  end
end