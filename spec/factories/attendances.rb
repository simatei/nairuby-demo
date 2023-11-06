FactoryBot.define do
  factory :attendance do
    association :event
    user_name { "John Doe" }
    email { Faker::Internet.email }
    phone_number { "+254 #{Faker::Number.leading_zero_number(digits: 10)}" }
  end
end