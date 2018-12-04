require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:invalid_project_name) {
    'Invalid project to check length of name that is 50 only'
  }
  
  describe "Validations" do
    let(:project) { FactoryBot.build(:project) }

    it "is valid with valid attributes" do
      expect(project).to be_valid
    end

    it "is not valid without an attributes" do
      expect(Project.new).to_not be_valid
    end

    it "is not valid without a name" do
      project.name = nil
      expect(project).to_not be_valid
    end

    it "is not valid without a user id" do
      project.user_id = nil
      expect(project).to_not be_valid
    end

    it "is not valid with a name length more then 50" do
      project.name = invalid_project_name
      expect(project).to_not be_valid
    end
  end

  describe "Actions" do
    it "has none to begin with" do
      expect(Project.count).to eq 0
    end

    it "has one after adding one" do
      FactoryBot.create(:project)
      expect(Project.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(Project.count).to eq 0
    end

    it "update project" do
      project = FactoryBot.create(:project)
      project.update(name: 'New Project')
      (project.name).should eq('New Project')
    end

    it "delete project" do
      project = FactoryBot.create(:project)
      expect(Project.count).to eq 1
      project.destroy
      expect(Project.count).to eq 0
    end
  end

  describe '.search_by_name' do
    before(:each) do
      @project = FactoryBot.create(:project)
    end

    it 'returns project that match with name' do
      expect(Project.where(name: @project.name).count).to eq 1
    end

    it 'returns project that like name' do
      expect(Project.where(name: @project.name.downcase).count).to eq 1
    end

    it 'returns project when name is blank' do
      expect(Project.where(name: '').count).to eq 0
    end

    it 'returns empty when name is not match' do
      expect(Project.where(name: 'not match').count).to eq 0
    end
  end
end
