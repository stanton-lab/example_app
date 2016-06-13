module Avatar::Service
  module Injector

    # @return [Avatar::Service::Create]
    def avatar(owner)
      form = form(owner)
      Avatar::Service::Create.new(form, crop_form(form.model))
    end

    def avatar_crop(avatar)
      Avatar::Service::Crop.new(crop_form(avatar))
    end

    private

    def form(owner)
      Avatar::Form::Create.new(owner.avatar || owner.build_avatar)
    end

    def crop_form(avatar)
      Avatar::Form::Crop.new(avatar)
    end

  end
end