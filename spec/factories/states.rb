FactoryBot.define do
  factory :state do
    name { Faker::Address.state }
    uf { %w(AB CD EF).sample }
    external_id { Faker::Number.number(digits: 3) }
  end
end
