require 'rails_helper'

module Department::Service
  describe Update do
    include Department::Service::Injector

    let(:department) { create(:department) }
    let(:invalid_params) { attributes_for(:department, name: '') }
    let(:params) {  attributes_for(:department, name: 'new_name') }

    describe '#run' do
      describe 'success' do
        it 'will update record' do
          service = update_service(create(:manager), department.id)
          service.run(params)
          service.model.reload
          expect(service.model.name).to eq(params[:name])
        end

        it 'will call success callback' do
          service = update_service(create(:manager), department.id)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = update_service(create(:manager), department.id)
          expect(service.run(invalid_params)).to be_falsey
          expect(service.model.name).to eq(department.name)
        end

        it 'will call success callback' do
          service = update_service(create(:manager), department.id)
          expect { |b| service.run(invalid_params, &b) }.to_not yield_control
        end
      end
    end
  end
end