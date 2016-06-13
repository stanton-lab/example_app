class ClientsController < ApplicationController
  include Client::Service::Injector
  include Avatar::Service::Injector

  add_breadcrumb 'Клиенты', :clients_path

  def index
    authorize! :read, Client
    clients_gird = initialize_grid(Client.real.ordered)
    render 'index', locals: { clients_gird: clients_gird }
  end

  def new
    authorize! :new, Client
    service = create_service(current_manager)
    service.form.prepopulate!
    add_breadcrumb 'Новый клиент'
    render 'new', locals: { service: service }
  end

  def create
    authorize! :create, Client
    service = create_service(current_manager)

    service.run(params[:client]) do
      flash[:success] = 'Запись успешно добавлена'
      return redirect_to edit_client_path(service.model)
    end

    service.form.prepopulate!
    add_breadcrumb 'Новый клиент'
    render 'new', locals: { service: service }
  end

  def edit
    authorize! :update, Client
    service = update_service(current_manager, params[:id])
    avatar  = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb service.model.company
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def update
    authorize! :update, Client

    service = update_service(current_manager, params[:id])

    service.run(params[:client]) do
      flash[:success] = 'Запись успешно изменена'
      return redirect_to edit_client_path(service.model)
    end

    avatar = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb service.model.company
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def destroy
    authorize! :destroy, Client
    Client.find(params[:id]).delete!
    flash[:success] = 'Запись успешно удалена'
    redirect_to clients_path
  end

end
