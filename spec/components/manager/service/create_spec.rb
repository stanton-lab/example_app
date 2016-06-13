require 'rails_helper'

module Manager::Service
  describe Create do
    include Manager::Service::Injector

    let(:params) { { manager: attributes_for(:manager_attributes) } }
    let(:invalid_params) { { manager: attributes_for(:manager_attributes, first_name: '') } }

    describe '#run' do
      describe 'success' do
        it 'will create correct record' do
          service = create_service(create(:manager))
          expect { service.run(params) }
            .to change { Manager.count }.by(1)
        end

        it 'will call success callback' do
          service = create_service(create(:manager))
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = create_service(create(:manager))
          expect(service.run(invalid_params)).to be_falsey
          expect { service.run(invalid_params) }
            .to_not change { Manager.count }
        end

        it 'will call success callback' do
          service = create_service(create(:manager))
          expect { |b| service.run(invalid_params, &b) }
            .to_not yield_control
        end
      end
    end
  end
end