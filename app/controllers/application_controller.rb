class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout -> (controller) { controller.request.xhr? ? false : 'application' }

  before_action :authenticate_manager!
  check_authorization

  add_breadcrumb 'Dashboard', :root_path

  rescue_from ::CanCan::AccessDenied do |exception|
    flash[:error] = 'Access denied'
    redirect_to root_path
  end


  # @return [Abilities::Ability]
  def current_ability
    @current_ability ||= current_manager.ability
  end

  # @return [Manager]
  def current_manager
    super
  end

  private
  def authenticate_manager!
    if manager_signed_in?
      sign_out(current_manager) if current_manager.inactive?
      super
    else
      redirect_to login_path
    end
  end

  def authorize!(*args)
    super
  end

end