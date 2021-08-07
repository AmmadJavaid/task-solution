FactoryBot.define do
  factory :post do
    title { "abc" }
    description { "acb@abc.com" }
    association :creator, factory: :user, strategy: :create
  end
end
