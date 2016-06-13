class Manager::Decorator < Draper::Decorator
  delegate_all


  # @return [Manager::Value::Status]
  def status
    @status ||= Manager::Value::Status.new(object.status)
  end

  def avatar_url(size = :thumb)
    url = object.avatar && object.avatar.url(size)
    url || h.image_path('admin/avatar/5.jpg')
  end

  private

  # @return [Manager]
  def object
    super
  end
end
