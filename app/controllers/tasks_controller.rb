class TasksController < ApplicationController
  before_action :authenticate_user!

  include CRUDActions

  def api_resource
    Task
  end

  private

  def allowed_params
    params.require(:task).permit(:name, :project_id, :priority, :status, :deadline)
  end
end
