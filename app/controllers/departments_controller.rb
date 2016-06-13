class DepartmentsController < ApplicationController
  include Department::Service::Injector

  add_breadcrumb 'Отделы', :departments_path

  def index
    authorize! :read, Department
    department_grid = initialize_grid(Department.real)
    render 'index', locals: { department_grid: department_grid }
  end

  def new
    authorize! :create, Department
    service = create_service(current_manager)
    add_breadcrumb 'Новый отдел'
    render 'new', locals: { service: service }
  end

  def create
    authorize! :create, Department
    service = create_service(current_manager)

    service.run(params[:department]) do
      flash[:success] = 'Запись успешно добавлена'
      return redirect_to departments_path
    end

    add_breadcrumb 'Новый отдел'
    render 'new', locals: { service: service }
  end

  def edit
    authorize! :update, Department
    service = update_service(current_manager, params[:id])
    add_breadcrumb service.model.name
    render 'edit', locals: { service: service }
  end

  def update
    authorize! :update, Department
    service = update_service(current_manager, params[:id])

    service.run(params[:department]) do
      flash[:success] = 'Запись успешно изменена'
      return redirect_to departments_path
    end

    add_breadcrumb service.model.name
    render 'edit', locals: { service: service }
  end

  def destroy
    authorize! :delete, Department
    Department.find(params[:id]).delete!
    flash[:success] = 'Запись успешно удалена'
    redirect_to departments_path
  end
end
