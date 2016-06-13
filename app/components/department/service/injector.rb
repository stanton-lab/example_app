module Department::Service::Injector

  # @return [Department::Service::Create]
  def create_service(current_user)
    ::Department::Service::Create.new(create_from(current_user))
  end

  def update_service(current_user, id)
    ::Department::Service::Update.new(update_form(current_user, id))
  end

  private

  def create_from(current_user)
    ::Department::Form::Create.new(Department.new)
  end

  def update_form(current_user, id)
    department = Department.find(id)
    ::Department::Form::Update.new(department)
  end
end