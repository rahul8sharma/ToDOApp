class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def destroy
    @project = Project.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  private

  def allowed_params
    params.require(:project).permit(:name).merge(user_id: current_user.id)
  end
end
