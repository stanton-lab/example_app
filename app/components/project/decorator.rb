class Project::Decorator < Draper::Decorator
  delegate_all

  def created_at(format = '%d-%m-%Y %H:%M:%S')
    object.created_at.strftime(format)
  end

  def updated_at(format = '%d-%m-%Y %H:%M:%S')
    object.updated_at.strftime(format)
  end

  def status
    object.is_active ? 'В процесе' : 'Завершен'
  end

  def status_label
    klass = is_active? ? 'label label-primary' : 'label label-danger'
    h.content_tag(:span, status, class: klass)
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
