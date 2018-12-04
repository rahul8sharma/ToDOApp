require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:invalid_task_name) {
    'Invalid task to check length of name that is 50 only'
  }

  before do
    sign_in(user)
  end

  describe "POST create" do
    before do
      @task_params = {
        task: FactoryBot.create(:task, project: project).attributes
      }
    end

    describe "with a valid details" do
      it "create task" do 
        expect {
          post :create, params: @task_params
        }.to change(Task, :count).by(1)
      end

      it 'renders project index template' do
        post :create, params: @task_params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @task_params[:task]['name'] = invalid_task_name
        expect { post :create, params: @task_params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "POST 'update/:id'" do
    before do
      @task = FactoryBot.create(:task, project: project)
      @params = {
        id: @task.id,
        task: {
          name: 'New Task',
          priority: 'low',
          status: 'start',
          project_id: project.id
        }
      }
    end

    describe "with a valid details" do
      it "allows an task to be updated" do
        put :update, params: @params
        @task = Task.find_by_id(@task.id)
        (@task.name).should eq('New Task')
        (@task.priority).should eq('low')
        (@task.status).should eq('start')
      end

      it 'renders project index template' do
        put :update, params: @params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @params[:task][:name] = invalid_task_name
        expect { put :update, params: @params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'DELETE destroy' do
    describe "with a valid id" do
      before do
        @task = FactoryBot.create(:task, project: project)
      end

      it 'removes task from table' do
        expect {
          delete :destroy, params: { id: @task }
        }.to change { Task.count }.by(-1)
      end

      it 'renders project index template' do
        delete :destroy, params: { id: @task }
        expect(response).to redirect_to projects_url
      end
    end

    describe "with an invalid ID" do
      it "should throw record not found error" do
        expect { delete :destroy, params: { id: 100 } }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
