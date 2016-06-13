class Manager::SessionsController < Devise::SessionsController
  layout 'login'

  skip_before_action :authenticate_manager!
  skip_authorization_check only: [:new, :create, :destroy]

  after_action do
    flash.delete(:notice)
  end

  def new
    form = Session::Form::SignIn.new
    render 'new', locals: {form: form}
  end

  def create
    form = Session::Form::SignIn.new(params[:sign_in])

    if form.valid?
      sign_in(form.manager)
      redirect_to root_path and return
    end

    render 'new', locals: {form: form}
  end


  private

  def respond_to_on_destroy
    respond_to do |format|
      format.html { redirect_to login_path }
    end
  end
end
