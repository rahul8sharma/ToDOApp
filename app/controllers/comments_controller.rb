class CommentsController < ApplicationController
	before_action :authenticate_user!

  include CRUDActions

  def api_resource
    Comment
  end

  private

  def allowed_params
    params.require(:comment).permit(:body, :task_id, :avatar).merge(user_id: current_user.id)
  end
end
