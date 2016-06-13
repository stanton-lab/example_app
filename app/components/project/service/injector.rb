module Project::Service
  module Injector

    def create_service(current_user)
      Project::Service::Create.new(create_from(current_user))
    end

    def update_service(current_user, id)
      Project::Service::Update.new(update_form(current_user, id))
    end

    private

    def create_from(current_user)
      Project::Form::Create.new(Project.new)
    end

    def update_form(current_user, id)
      manager = Project.find(id)
      Project::Form::Update.new(manager)
    end
  end
end