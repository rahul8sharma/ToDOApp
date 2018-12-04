require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    let(:task) { FactoryBot.build(:task) }
    let(:invalid_task_name) {
      'Invalid task to check length of name that is 50 only'
    }

    it "is valid with valid attributes" do
      expect(task).to be_valid
    end

    it "is not valid without an attributes" do
      expect(Task.new).to_not be_valid
    end

    it "is not valid without a name" do
      task.name = nil
      expect(task).to_not be_valid
    end

    it "is not valid without a project id" do
      task.project_id = nil
      expect(task).to_not be_valid
    end

    it "is not valid without a priority" do
      task.priority = nil
      expect(task).to_not be_valid
    end

    it "is not valid without a status" do
      task.status = nil
      expect(task).to_not be_valid
    end

    it "is not valid with a name length more then 50" do
      task.name = invalid_task_name
      expect(task).to_not be_valid
    end
  end

  describe "Actions" do
    it "has none to begin with" do
      expect(Task.count).to eq 0
    end

    it "has one after adding one" do
      FactoryBot.create(:task)
      expect(Task.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(Task.count).to eq 0
    end

    it "update task" do
      task = FactoryBot.create(:task)
      task.update(name: 'New Task')
      (task.name).should eq('New Task')
    end

    it "delete task" do
      task = FactoryBot.create(:task)
      expect(Task.count).to eq 1
      task.destroy
      expect(Task.count).to eq 0
    end
  end

  describe '.search_by_name' do
    before(:each) do
      @task = FactoryBot.create(:task)
    end

    it 'returns task that match with name' do
      expect(Task.where(name: @task.name).count).to eq 1
    end

    it 'returns task that like name' do
      expect(Task.where(name: @task.name.downcase).count).to eq 1
    end

    it 'returns task when name is blank' do
      expect(Task.where(name: '').count).to eq 0
    end

    it 'returns empty when name is not match' do
      expect(Task.where(name: 'not match').count).to eq 0
    end
  end
end
