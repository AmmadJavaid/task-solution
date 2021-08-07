FactoryBot.define do
  factory :comment do
    title { "abc" }
    description { "acb@abc.com" }
    association :user, factory: :user, strategy: :create
    association :post, factory: :post, strategy: :create
  end
end
