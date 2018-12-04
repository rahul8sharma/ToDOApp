require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:invalid_project_name) {
    'Invalid project to check length of name that is 50 only'
  }

  before do
    sign_in(user)
  end

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
    
    it "assigns @projects" do
      get :index
      expect(assigns(:projects)).to eq([project])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "new @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    before do
      @project_params = {
        project: FactoryBot.build(:project, user: user).attributes
      }
    end

    describe "with a valid details" do
      it "create project" do 
        expect {
          post :create, params: @project_params
        }.to change(Project, :count).by(1)
      end

      it 'renders project index template' do
        post :create, params: @project_params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @project_params[:project]['name'] = invalid_project_name
        expect { post :create, params: @project_params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "POST 'update/:id'" do
    before do
      @project = FactoryBot.create(:project, user: user)
      @params = {
        id: @project.id,
        project: {name: 'New Project'}
      }
    end

    describe "with a valid details" do
      it "allows an project to be updated" do
        put :update, params: @params
        @project = Project.find_by_id(@project.id)
        (@project.name).should eq('New Project')
      end

      it 'renders project index template' do
        put :update, params: @params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @params[:project][:name] = invalid_project_name
        expect { put :update, params: @params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'DELETE destroy' do
    describe "with a valid id" do
      before do
        @project = FactoryBot.create(:project, user: user)
      end

      it 'removes project from table' do
        expect {
          delete :destroy, params: { id: @project }
        }.to change { Project.count }.by(-1)
      end

      it 'renders project index template' do
        delete :destroy, params: { id: @project }
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
