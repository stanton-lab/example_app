module Avatar::Service
  class Create < ::Common::Service::Base
    #@!attribute [Avatar::Form::Crop]
    attr_reader :crop

    def initialize(form, crop)
      super(form)
      @crop = crop
    end
  end
end