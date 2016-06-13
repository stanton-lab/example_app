class CommentDecorator < Draper::Decorator
  delegate_all

  def created_at(format = '%d-%m-%Y %H:%M:%S')
    object.created_at.strftime(format)
  end

  def updated_at(format = '%d-%m-%Y %H:%M:%S')
    object.updated_at.strftime(format)
  end

  private

  # @return [Comment]
  def object
    super
  end
end
