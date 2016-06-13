module Manager::Value
  class Status
    include ActionView::Helpers::TagHelper

    ACTIVE   = :active
    INACTIVE = :inactive

    class << self
      def items
        { ACTIVE => 0, INACTIVE => 1 }
      end

      def list
        {
          'Активный'    => ACTIVE,
          'Не активный' => INACTIVE,
        }
      end

      def list_raw
        list.map { |key, item| [key, value(item)] }.to_h
      end

      def value(item)
        items[item]
      end
    end

    def initialize(status)
      @status = status.to_sym
    end

    def title
      self.class.list_raw.key(code)
    end

    def label
      return active_label if @status == ACTIVE
      return inactive_label if @status == INACTIVE
      ''
    end

    private

    def code
      self.class.items[@status]
    end

    def inactive_label
      content_tag(:span, title, class: 'label label-danger')
    end

    def active_label
      content_tag(:span, title, class: 'label label-success')
    end
  end
end