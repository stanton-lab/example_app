class ManagersController < ApplicationController
  include Manager::Service::Injector
  include Avatar::Service::Injector

  add_breadcrumb 'Сотрудники', :managers_path

  def index
    authorize! :read, Manager
    manager_grid = initialize_grid(Manager.real.ordered)
    render 'index', locals: { manager_grid: manager_grid }
  end

  def new
    authorize! :create, Manager
    service = create_service(current_manager)
    service.form.prepopulate!
    add_breadcrumb 'Новый сотрудник'
    render 'new', locals: { service: service }
  end

  def create
    authorize! :create, Manager
    service = create_service(current_manager)

    service.run(params[:manager]) do
      flash[:success] = 'Запись успешно добавлена'
      return redirect_to edit_manager_path(service.model)
    end

    service.form.prepopulate!
    add_breadcrumb 'Новый сотрудник'
    render 'new', locals: { service: service }
  end

  def edit
    authorize! :update, Manager
    service = update_service(current_manager, params[:id])
    avatar  = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb service.model.full_name
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def update
    authorize! :update, Manager
    service = update_service(current_manager, params[:id])

    service.run(params[:manager]) do
      flash[:success] = 'Запись успешно изменена'
      return redirect_to edit_manager_path(service.model)
    end

    avatar  = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb service.model.full_name
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def destroy
    authorize! :delete, Manager
    Manager.find(params[:id]).delete!
    flash[:success] = 'Запись успешно удалена'
    redirect_to managers_path
  end
end
