FactoryBot.define do
  factory :event do
    name { "Annual Tech Conference" }
    location { "Convention Center" }
    date { 3.days.from_now }
  end
end