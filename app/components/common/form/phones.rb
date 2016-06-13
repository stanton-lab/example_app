module Common::Form
  module Phones
    include ::Reform::Form::Module

    collection :phones,
               prepopulator:      :prepopulate_phones!,
               populate_if_empty: Phone,
               skip_if:           :skip_phone? do

      property :phone
      property :_destroy, virtual: true

      delegate :new_record?, :marked_for_destruction?, to: :model
    end

    validates :phones,
              length: { in:        1..3,
                        too_short: 'нужно указать телефон',
                        too_long:  'максимальное количество телефонов %{count}' }

    private

    def prepopulate_phones!(options)
      self.phones << Phone.new if self.phones.blank?
    end

    def skip_phone?(options)
      if options[:fragment][:_destroy] == '1'
        phones.delete(phones.find { |x| x.id.to_s == options[:fragment]['id'] })
        true
      end
      true if options[:fragment][:phone].blank?
    end
  end
end