class WorksController < ApplicationController
  add_breadcrumb 'Услуги', :works_path

  def index
    authorize! :read, Work
    works_gird = initialize_grid(Work.real.order(created_at: 'desc'))
    render 'index', locals: { works_gird: works_gird }
  end

  def new
    authorize! :new, Work
    work = Work.new
    add_breadcrumb 'new', :new_work_url
    render 'new', locals: { work: work }
  end

  def create
    authorize! :create, Work
    work = Work.new(work_params)
    if work.save
      flash[:success] = 'Запись успешно добавлена'
      redirect_to works_path
    else
      add_breadcrumb 'Создание услуги', :new_work_url
      render 'new', locals: { work: work }
    end
  end

  def edit
    authorize! :update, Work
    work = Work.find(params[:id])

    add_breadcrumb work.name, edit_work_path(work)
    render 'edit', locals: { work: work }
  end

  def update
    authorize! :update, Work
    work = Work.find(params[:id])
    if work.update(work_params)
      flash[:success] = 'Запись успешно изменена'
      redirect_to works_path
    else
      render 'edit', locals: { work: work }
    end
  end

  def destroy
    authorize! :destroy, Work
    work = Work.find(params[:id])
    work.destroy!
    flash[:success] = 'Запись успешно удалена'
    redirect_to works_path
  end

  private

  def work_params
    work_params = [:name, :is_iterative, :percent, :department_id]
    params
      .require(:work)
      .permit(work_params)
  end
end
