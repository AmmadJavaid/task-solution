FactoryBot.define do
  factory :comment do
    message { "abc" }
    association :user, factory: :user, strategy: :create
    association :post, factory: :post, strategy: :create
  end
end
