module Manager::Service
  class Create < ::Common::Service::Base

    def run(params, &success)
      return unless form.validate(params[:manager])

      form.save
      form.model.roles = []
      form.model.add_role(form.role)
      success.call(form.model) if success.present?
    end
  end
end