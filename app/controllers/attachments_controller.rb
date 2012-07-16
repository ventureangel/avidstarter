class AttachmentsController < ApplicationController
  def create
    @project = current_account.projects.find(params[:attachment][:project_id].to_i)
    @attachment = Attachment.new(project_id: @project.id, file: params[:attachment][:file])
    if @attachment.save
      flash[:notice] = "Attachment successfully uploaded"
      redirect_to :back
    else
      flash[:warning] = "Attachment not added. Please try again."
      redirect_to :back
    end
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot upload attachments this project.'   
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    if current_account.projects.include?(Project.find(@attachment.project_id))
      if @attachment.destroy
        flash[:notice] = "Attachment successfully removed"
        redirect_to :back
      else
        flash[:warning] = "Attachment not removed. Please try again."
        redirect_to :back
      end
    else
      flash[:warning] = "You cannot remove attachments from this project."
      redirect_to :root
    end
  end
end
