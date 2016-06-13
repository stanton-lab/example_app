require 'rails_helper'

describe Client::Service::Injector do
  include Client::Service::Injector

  let(:current_user) { create(:manager) }

  describe '#create_service' do
    it 'will build correct create service' do
      service = create_service(current_user)
      expect(service).to be_instance_of(Client::Service::Create)
      expect(service.form).to be_instance_of(Client::Form::Create)
    end
  end

  describe '#update_service' do
    it 'will build correct update service' do
      client = create(:client)
      service = update_service(current_user, client.id)
      expect(service).to be_instance_of(Client::Service::Update)
      expect(service.form).to be_instance_of(Client::Form::Update)
    end

    it 'will find correct client record' do
      client = create(:client)
      service    = update_service(current_user, client.id)
      expect(service.model).to eq(client)
    end
  end
end