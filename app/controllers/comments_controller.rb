class CommentsController < ApplicationController
  
  def index
    if account_signed_in?
      if params[:project_id]
        @commentable = Project.find(params[:project_id], :include => [:comment_threads])
        @project = @commentable
      else
        @commentable = Account.find(params[:account_id], :include => [:comment_threads])
        @project = @commentable
      end
    else
      return redirect_to root_url, :alert => 'You cannot access this feature'
    end
    @breadcrumb_name = "Comments"
  end

  def create
    @commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    @project = @commentable
    @comment = Comment.build_from(@commentable, current_account.id, params[:comment][:body])
    
    if @comment.save
      @comment.move_to_child_of(Comment.find(params[:comment][:parent_id])) if params[:comment][:parent_id].present?
      flash[:notice] = "Comment successfully posted"
      redirect_to :back
    else
      flash[:warning] = "Comment not posted"
      redirect_to :back
    end
  end
=begin JAVASCRIPT STUFF FROM VA
    respond_to do |format|
      if @comment.save
        @comment.move_to_child_of(Comment.find(params[:comment][:parent_id])) if params[:comment][:parent_id].present?
        
        format.html { 
          redirect_to :back, :notice => "Comment successfully posted"
          }
        format.js
      else
        format.html {
          redirect_to :back
          flash[:warning] = "Comment not saved"
        }
        format.js {
          flash[:warning] = "Comment not saved"
        } 
      end
=end

  def destroy
  end
end
