FactoryBot.define do
  factory :task do
    name { Faker::Name.name }
    priority { 'low' }
    status { 'start' }
    deadline { '' }
    association :project, factory: :project
  end
end