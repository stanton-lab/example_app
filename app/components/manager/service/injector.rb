module Manager::Service
  module Injector

    # @return [Manager::Service::Create]
    def create_service(current_user)
      Manager::Service::Create.new(create_from(current_user))
    end

    # @return [Manager::Service::Update]
    def update_service(current_user, id)
      Manager::Service::Update.new(update_form(current_user, id))
    end

    private

    def create_from(current_user)
      Manager::Form::Create.new(Manager.new)
    end

    def update_form(current_user, id)
      manager = Manager.find(id)
      Manager::Form::Update.new(manager)
    end
  end
end