require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:task) { FactoryBot.create(:task, project: project) }
  let(:comment) { FactoryBot.create(:comment, task: task, user: user) }
  let(:invalid_comment_name) {
    'Invalid task to check length of name that is 100 only + Invalid task to check length of name that is 100 only'
  }

  before do
    sign_in(user)
  end

  describe "POST create" do
    before do
      @comment_params = {
        comment: FactoryBot.create(:comment, task: task, user: user).attributes
      }
    end

    describe "with a valid details" do
      it "create comment" do 
        expect {
          post :create, params: @comment_params
        }.to change(Comment, :count).by(1)
      end

      it 'renders project index template' do
        post :create, params: @comment_params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @comment_params[:comment]['body'] = invalid_comment_name
        expect { post :create, params: @comment_params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "POST 'update/:id'" do
    before do
      @comment = FactoryBot.create(:comment, task: task, user: user)
      @params = {
        id: @comment.id,
        comment: {
          body: 'New Comment',
          task_id: task.id
        }
      }
    end

    describe "with a valid details" do
      it "allows an comment to be updated" do
        put :update, params: @params
        @comment = Comment.find_by_id(@comment.id)
        (@comment.body).should eq('New Comment')
      end

      it 'renders project index template' do
        put :update, params: @params
        expect(response).to redirect_to projects_url
      end
    end

    describe "with a invalid details" do
      it "should throw record invalid error" do
        @params[:comment][:body] = invalid_comment_name
        expect { put :update, params: @params }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'DELETE destroy' do
    describe "with a valid id" do
      before do
        @comment = FactoryBot.create(:comment, task: task, user: user)
      end

      it 'removes comment from table' do
        expect {
          delete :destroy, params: { id: @comment }
        }.to change { Comment.count }.by(-1)
      end

      it 'renders project index template' do
        delete :destroy, params: { id: @comment }
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
