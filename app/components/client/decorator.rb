class Client::Decorator < Draper::Decorator
  delegate_all

  def created_at(format = '%d-%m-%Y %H:%M:%S')
    object.created_at.strftime(format)
  end

  def updated_at(format = '%d-%m-%Y %H:%M:%S')
    object.updated_at.strftime(format)
  end

  def avatar_url(size = :thumb)
    url = object.avatar && object.avatar.url(size)
    url || h.image_path('no-image-found.jpg')
  end

  private

  # @return [Project]
  def object
    super
  end
end
