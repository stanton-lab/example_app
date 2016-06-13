class Session::Form::SignIn < Reform::Form
  property :email, virtual: true
  property :password, virtual: true

  validates :email, presence: true
  validates :password, presence: true

  validate :password_ok?

  attr_reader :manager

  def initialize(params = {})
    super Manager.new, params
  end

  private

  def password_ok?
    @manager = Manager.login(email).take
    add_password_error and return if @manager.blank?
    add_inactive_error and return if @manager.inactive?
    add_password_error unless @manager.valid_password?(password)
  end

  def add_password_error
    clear_password
    errors.add(:base, 'Неверный логин или пароль')
  end

  def add_inactive_error
    clear_password
    errors.add(:base, 'Ваша учетная запись заблокирована')
  end

  def clear_password
    self.password = nil
  end
end
