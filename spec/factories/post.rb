FactoryBot.define do
  factory :post do
    title { "abc" }
    description { "abc description" }
    association :creator, factory: :user, strategy: :create
  end
end
