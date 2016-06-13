module Manager::Form
  class Create < Base
    include ::Manager::Form::Base::Fields

    validates :password, presence: true, length: 8..22, confirmation: true
    validates :password_confirmation, presence: true, length: 8..22

    def required?(field)
      [:password, :password_confirmation].include?(field)
    end
  end
end