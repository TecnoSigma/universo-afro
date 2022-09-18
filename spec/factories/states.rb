FactoryBot.define do
  factory :state do
    name { Faker::Address.state }
    external_id { Faker::Number.number }
  end
end
