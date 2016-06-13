require 'rails_helper'

module Manager::Service
  describe Update do
    include Manager::Service::Injector

    let(:manager) { create(:manager) }
    let(:invalid_params) { { manager: attributes_for(:manager_attributes,
                                                     first_name: '') } }
    let(:params) { { manager: attributes_for(:manager_attributes) } }

    describe '#run' do
      describe 'success' do
        it 'will update record' do
          service = update_service(create(:manager), manager.id)
          service.run(params)
          service.model.reload
          expect(service.model.first_name).to eq(params[:manager][:first_name])
        end

        it 'will call success callback' do
          service = update_service(create(:manager), manager.id)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = update_service(create(:manager), manager.id)
          expect(service.run(invalid_params)).to be_falsey
          expect(service.model.first_name).to eq(manager.first_name)
        end

        it 'will call success callback' do
          service = update_service(create(:manager), manager.id)
          expect { |b| service.run(invalid_params, &b) }.to_not yield_control
        end
      end
    end
  end
end