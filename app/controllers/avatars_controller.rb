class AvatarsController < ApplicationController
  include Avatar::Service::Injector
  layout false
  respond_to :js

  def create
    authorize! :upload, Avatar
    service = avatar(owner)
    service.run(params[:avatar]) do
      return render 'create', locals: { service: service }
    end

    render 'error', locals: { service: service }
  end

  def crop
    authorize! :update, Avatar
    service = avatar_crop(owner.avatar)
    service.run(params[:avatar]) do
      return render 'crop', locals: { service: service }
    end
    render 'error', locals: { service: service }
  end

  def destroy
    authorize! :destroy, Avatar
    owner.avatar.destroy
    render 'destroy'
  end

  private

  def owner
    return Client.find(params[:client_id]) if params[:client_id].present?
    return Project.find(params[:project_id]) if params[:project_id].present?
    Manager.find(params[:manager_id]) if params[:manager_id].present?
  end
end
