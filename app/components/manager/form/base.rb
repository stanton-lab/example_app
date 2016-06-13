module Manager::Form
  class Base < ::Reform::Form
    include ::Reform::Form::ActiveModel::ModelReflections

    model :manager

    module Fields
      include ::Reform::Form::Module
      include ::Common::Form::Phones

      property :last_name
      property :first_name
      property :birthday
      property :worked_at
      property :skype

      property :email
      property :password
      property :password_confirmation, virtual: true


      property :department_id
      property :role, virtual: true
      property :status, default: ::Manager::Value::Status::ACTIVE

      validates :last_name, presence: true, length: 2..18
      validates :first_name, presence: true, length: 2..18
      validates :birthday, presence: true
      validates :worked_at, presence: true
      validates :skype, length: 2..18, allow_blank: true

      validates :email, presence: true, email: true

      validates :department_id, presence: true
      validates :role, presence: true

      def self.included(base)
        super
        base.include InstanceMethods
      end

      module InstanceMethods
        def birthday
          return if super.blank?
          super.to_date.strftime('%d-%m-%Y')
        end

        def worked_at
          return if super.blank?
          super.to_date.strftime('%d-%m-%Y')
        end

      end

    end


    def sync
      model.full_name = "#{first_name} #{last_name}"
      super
    end

    def new_record?
      model.persisted?
    end
  end
end