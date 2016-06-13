require 'rails_helper'

module Department::Service
  describe Create do
    include Department::Service::Injector

    let(:params) { attributes_for(:department) }
    let(:invalid_params) { attributes_for(:department, name: '') }

    describe '#run' do
      describe 'success' do
        it 'will create correct record' do
          service = create_service(create(:manager))
          expect { service.run(params) }.to change { Department.count }.by(1)
        end

        it 'will call success callback' do
          service = create_service(create(:manager))
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = create_service(create(:manager), )
          expect(service.run(invalid_params)).to be_falsey
          expect { service.run(invalid_params) }
            .to_not change { Department.count }
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