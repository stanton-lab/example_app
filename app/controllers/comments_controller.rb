class CommentsController < ApplicationController
  layout false

  def create
    authorize! :upload, Comment
    project         = Project.find(params[:project_id])
    comment         = project.comments.build(comment_params.merge({manager_id: current_manager.id}))
    template        = 'create'
    unless comment.save
      template      = 'error'
    end
    respond_to do |format|
      format.js { render template, locals: { comment: comment,
                                             project: project} }
    end
  end

  def destroy
    authorize! :destroy, Comment
    project = Project.find(params[:project_id])
    comment = project.comments.find(params[:id])
    comment.destroy!
    respond_to do |format|
      format.js { render 'destroy', locals: { comment: comment} }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
