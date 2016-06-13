module UtilityHelper
  def horizontal_form(path, options = {}, &block)
    merged_options = options.deep_merge(html: {class: ['form-horizontal']}, wrapper: :horizontal_form)
    merged_options[:html][:class] << options[:html][:class] if options[:html] && options[:html][:class]
    simple_form_for(path, merged_options, &block)
  end
end