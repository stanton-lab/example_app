module Avatar::Service
  class Crop < ::Common::Service::Base
    def run(params, &success)
      return unless form.validate(params)
      form.sync
      form.model.crop
      success.call(form.model) if success.present?
    end
  end
end