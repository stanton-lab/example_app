require 'rails_helper'

describe Avatar::Service::Injector do
  include Avatar::Service::Injector

  let(:project) { create(:project) }

  describe '#avatar' do
    it 'will build correct create service' do
      service = avatar(project)
      expect(service).to be_instance_of(Avatar::Service::Create)
      expect(service.form).to be_instance_of(Avatar::Form::Create)
    end
  end

  describe '#avatar_crop' do
    it 'will build correct update service' do
      service = avatar_crop(project.avatar)
      expect(service).to be_instance_of(Avatar::Service::Crop)
      expect(service.form).to be_instance_of(Avatar::Form::Crop)
    end

    it 'will find correct client record' do
      service    = avatar_crop(project.avatar)
      expect(service.model).to eq(project.avatar)
    end
  end
end