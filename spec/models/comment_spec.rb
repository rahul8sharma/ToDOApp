require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:invalid_comment_name) {
    'Invalid task to check length of name that is 100 only + Invalid task to check length of name that is 100 only'
  }
  
  describe "Validations" do
    let(:comment) { FactoryBot.build(:comment) }

    it "is valid with valid attributes" do
      expect(comment).to be_valid
    end

    it "is not valid without an attributes" do
      expect(Comment.new).to_not be_valid
    end

    it "is not valid without a body" do
      comment.body = nil
      expect(comment).to_not be_valid
    end

    it "is not valid without a task id" do
      comment.task_id = nil
      expect(comment).to_not be_valid
    end

    it "is not valid without a user id" do
      comment.user_id = nil
      expect(comment).to_not be_valid
    end

    it "is not valid with a body length more then 50" do
      comment.body = invalid_comment_name
      expect(comment).to_not be_valid
    end
  end

  describe "Actions" do
    it "has none to begin with" do
      expect(Comment.count).to eq 0
    end

    it "has one after adding one" do
      FactoryBot.create(:comment)
      expect(Comment.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(Comment.count).to eq 0
    end

    it "update comment" do
      comment = FactoryBot.create(:comment)
      comment.update(body: 'New Comment')
      (comment.body).should eq('New Comment')
    end

    it "delete comment" do
      comment = FactoryBot.create(:comment)
      expect(Comment.count).to eq 1
      comment.destroy
      expect(Comment.count).to eq 0
    end
  end

  describe '.search_by_name' do
    before(:each) do
      @comment = FactoryBot.create(:comment)
    end

    it 'returns comment that match with body' do
      expect(Comment.where(body: @comment.body).count).to eq 1
    end

    it 'returns comment that like body' do
      expect(Comment.where(body: @comment.body.downcase).count).to eq 1
    end

    it 'returns comment when body is blank' do
      expect(Comment.where(body: '').count).to eq 0
    end

    it 'returns empty when body is not match' do
      expect(Comment.where(body: 'not match').count).to eq 0
    end
  end
end
