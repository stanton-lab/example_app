class ProjectsController < ApplicationController
  include Project::Service::Injector
  include Avatar::Service::Injector

  add_breadcrumb 'Проекты', :projects_path

  def index
    authorize! :read, Project
    projects_gird = initialize_grid(Project.real)
    render 'index', locals: { projects_gird: projects_gird }
  end

  def new
    authorize! :new, Project
    service = create_service(current_manager)
    service.form.prepopulate!
    add_breadcrumb 'Новый проект'
    render 'new', locals: { service: service }
  end

  def create
    authorize! :create, Project
    service = create_service(current_manager)

    service.run(params[:project]) do
      flash[:success] = 'Запись успешно добавлена'
      return redirect_to edit_project_path(service.model)
    end

    service.form.prepopulate!
    add_breadcrumb 'Новый проект'
    render 'new', locals: { service: service }
  end

  def edit
    authorize! :update, Project

    service = update_service(current_manager, params[:id])
    avatar  = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb service.model.name
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def update
    authorize! :update, Project
    service = update_service(current_manager, params[:id])

    service.run(params[:project]) do
      flash[:success] = 'Запись успешно добавлена'
      return redirect_to edit_project_path(service.model)
    end

    avatar  = avatar(service.model)
    service.form.prepopulate!
    add_breadcrumb 'Новый проект'
    render 'edit', locals: { service: service, avatar: avatar }
  end

  def destroy
    authorize! :destroy, Project
    Project.find(params[:id]).destroy!
    flash[:success] = 'Запись успешно удалена'
    redirect_to projects_path
  end
end
