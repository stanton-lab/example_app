require 'rails_helper'

describe Project::Service::Injector do
  include Project::Service::Injector

  let(:current_user) { create(:manager) }

  describe '#create_service' do
    it 'will build correct create service' do
      service = create_service(current_user)
      expect(service).to be_instance_of(Project::Service::Create)
      expect(service.form).to be_instance_of(Project::Form::Create)
    end
  end

  describe '#update_service' do
    it 'will build correct update service' do
      project = create(:project)
      service = update_service(current_user, project.id)
      expect(service).to be_instance_of(Project::Service::Update)
      expect(service.form).to be_instance_of(Project::Form::Update)
    end

    it 'will find correct client record' do
      project = create(:project)
      service    = update_service(current_user, project.id)
      expect(service.model).to eq(project)
    end
  end
end