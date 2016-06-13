module Client::Service
  module Injector

    def create_service(current_user)
      ::Client::Service::Create.new(create_from(current_user))
    end

    def update_service(current_user, id)
      ::Client::Service::Update.new(update_form(current_user, id))
    end

    private

    def create_from(current_user)
      ::Client::Form::Create.new(Client.new)
    end

    def update_form(current_user, id)
      model = ::Client.find(id)
      ::Client::Form::Update.new(model)
    end
  end
end