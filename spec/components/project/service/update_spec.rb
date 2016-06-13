require 'rails_helper'

module Project::Service
  describe Update do
    include Project::Service::Injector

    let(:project) { create(:project) }
    let(:invalid_params) { attributes_for(:project_attributes, name: '') }
    let(:params) { attributes_for(:project_attributes) }
    let(:current_user) { create(:manager) }

    describe '#run' do
      describe 'success' do
        it 'will update record' do
          service = update_service(current_user, project.id)
          service.run(params)
          service.model.reload
          expect(service.model.name).to eq(params[:name])
        end

        it 'will call success callback' do
          service = update_service(current_user, project.id)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = update_service(current_user, project.id)
          expect(service.run(invalid_params)).to be_falsey
          expect(service.model.name).to eq(project.name)
        end

        it 'will call success callback' do
          service = update_service(current_user, project.id)
          expect { |b| service.run(invalid_params, &b) }.to_not yield_control
        end
      end
    end
  end
end