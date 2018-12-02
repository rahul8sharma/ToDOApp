class CommentsController < ApplicationController
	before_action :authenticate_user!

  def create
    @comment = Comment.create!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def destroy
    @comment = Comment.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  private

  def allowed_params
    params.require(:comment).permit(:body, :task_id, :avatar).merge(user_id: current_user.id)
  end
end
