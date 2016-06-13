module Common::Service
  class Base
    attr_reader :form

    delegate :model, to: :form

    def initialize(form)
      @form = form
    end

    def run(params, &success)
      return unless form.validate(params)

      # before_save callbacks
      form.save
      # after_save callbacks

      success.call(form.model) if success.present?
    end
  end
end