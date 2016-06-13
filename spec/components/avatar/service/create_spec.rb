require 'rails_helper'

module Avatar::Service
  describe Create do
    include Avatar::Service::Injector

    let(:params) { attributes_for(:avatar) }
    let(:invalid_params) { attributes_for(:avatar_invalid) }
    let(:project) { build(:project, avatar: nil) }

    describe '#run' do
      describe 'success' do
        it 'will create correct record' do
          service = avatar(project)
          expect { service.run(params) }
            .to change { Avatar.count }.by(1)
        end

        it 'will call success callback' do
          service = avatar(project)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = avatar(project)
          expect(service.run(invalid_params)).to be_falsey
          expect { service.run(invalid_params) }
            .to_not change { Avatar.count }
        end

        it 'will call success callback' do
          service = avatar(project)
          expect { |b| service.run(invalid_params, &b) }
            .to_not yield_control
        end
      end
    end
  end
end