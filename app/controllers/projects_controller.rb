class ProjectsController < ApplicationController
  before_action :authenticate_user!

  include CRUDActions

  def api_resource
    Project
  end

  private

  def allowed_params
    params.require(:project).permit(:name).merge(user_id: current_user.id)
  end
end
