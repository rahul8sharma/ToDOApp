class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.create!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def destroy
    @task = Task.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  private

  def allowed_params
    params.require(:task).permit(:name, :project_id, :priority, :status, :deadline)
  end
end
