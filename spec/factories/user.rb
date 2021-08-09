FactoryBot.define do
  factory :user do
    name { "abc" }
    sequence :email do |n|
      "user#{n}@acb.cs"
    end
    password { "password" }
  end
end
