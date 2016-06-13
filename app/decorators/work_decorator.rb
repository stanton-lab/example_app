class WorkDecorator < Draper::Decorator
  delegate_all

  def status
    if is_iterative?
      h.content_tag(:span, 'Итерационная',
                    class: 'label label-primary')
    else
      h.content_tag(:span, 'Не итерационная',
                    class: 'label label-success')
    end
  end
end