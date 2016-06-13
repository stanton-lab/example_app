require 'rails_helper'

module Project::Service
  describe Create do
    include Project::Service::Injector

    let(:project) { create(:project) }
    let(:params) { attributes_for(:project_attributes) }
    let(:invalid_params) { attributes_for(:project_attributes, name: '') }
    let(:current_user) { create(:manager) }

    describe '#run' do
      describe 'success' do
        it 'will create correct record' do
          service = create_service(current_user)
          expect { service.run(params) }
            .to change { Project.count }.by(1)
        end

        it 'will call success callback' do
          service = create_service(current_user)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = create_service(current_user)
          expect(service.run(invalid_params)).to be_falsey
          expect { service.run(invalid_params) }
            .to_not change { Project.count }
        end

        it 'will call success callback' do
          service = create_service(current_user)
          expect { |b| service.run(invalid_params, &b) }
            .to_not yield_control
        end
      end
    end
  end
end