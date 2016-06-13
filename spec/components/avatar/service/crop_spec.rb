require 'rails_helper'

module Avatar::Service
  describe Crop do
    include Avatar::Service::Injector

    let(:params) { attributes_for(:avatar_crop_params) }
    let(:invalid_crop_params) { attributes_for(:avatar_crop_invalid)  }
    let(:project) { build(:project) }

    describe '#run' do
      describe 'success' do
        it 'will create correct record' do
          service = avatar_crop(project.avatar)
          expect { service.run(params) }
            .to change { project.avatar.crop_x }
        end

        it 'will call success callback' do
          service = avatar_crop(project.avatar)
          expect { |b| service.run(params, &b) }.to yield_control
        end
      end

      describe 'dont success' do
        it 'will dont create record' do
          service = avatar_crop(project.avatar)
          expect(service.run(invalid_crop_params)).to be_falsey
          expect { service.run(invalid_crop_params) }
            .to_not change { project.avatar.crop_x }
        end

        it 'will not call success callback' do
          service = avatar_crop(project.avatar)
          expect { |b| service.run(invalid_crop_params, &b) }
            .to_not yield_control
        end
      end
    end
  end
end