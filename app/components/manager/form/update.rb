module Manager::Form
  class Update < Base
    include ::Manager::Form::Base::Fields

    validates :password,
              length:       8..22,
              confirmation: { message: 'не совпадает со значением поля Пароль' },
              allow_blank:  true

    validates :password_confirmation, length: 8..22, allow_blank: true


    def required?(field)
      [].include?(field)
    end

    def role
      super || (model.roles.first&.id)
    end
  end
end