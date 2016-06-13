module Client::Form
  class Create < ::Reform::Form
    include ::Reform::Form::ActiveModel::ModelReflections
    model :client

    property :company

    collection :contact_people,
               prepopulator:      :prepopulate_contact_people!,
               populate_if_empty: ContactPerson,
               skip_if:           :skip_contact_person? do

      include ::Common::Form::Phones

      property :full_name
      property :email
      property :_destroy, virtual: true

      validates :full_name, presence: true, length: 2..36
      validates :email, presence: true, email: true

      delegate :new_record?, :marked_for_destruction?, to: :model
    end

    validates :contact_people,
              length: { in:        1..3,
                        too_short: 'нужно указать контактное лицо',
                        too_long:  'максимальное количество контактных лиц %{count}' }


    validates :company, presence: true, length: 2..36

    private

    def prepopulate_contact_people!(options)
      self.contact_people << ContactPerson.new if self.contact_people.blank?
    end

    def skip_contact_person?(options)
      if options[:fragment][:_destroy] == '1'
        for_delete = contact_people.find { |x| x.id.to_s == options[:fragment]['id'] }
        contact_people.delete(for_delete)
        true
      end
    end
  end
end