require 'rails_helper'

module Client::Service
  describe Update do
    include Client::Service::Injector

    let(:client) { create(:client) }
    let(:invalid_params) { attributes_for(:client_attributes, company: '') }
    let(:params) {  attributes_for(:client_attributes) }
    let(:current_user) { create(:manager) }

    describe '#run' do
      describe 'success' do
        it 'will update record' do
          service = update_service(current_user, client.id)
          service.run(params)
          service.model.reload
          expect(service.model.company).to eq(params[:company])
        end

        it 'will call success callback' do
          service = update_service(current_user, client.id)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = update_service(current_user, client.id)
          expect(service.run(invalid_params)).to be_falsey
          expect(service.model.company).to eq(client.company)
        end

        it 'will call success callback' do
          service = update_service(current_user, client.id)
          expect { |b| service.run(invalid_params, &b) }.to_not yield_control
        end
      end
    end
  end
end