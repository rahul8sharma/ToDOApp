FactoryBot.define do
  factory :comment do
  	body { Faker::Name.name }
    association :task, factory: :task
    association :user, factory: :user
  end
end