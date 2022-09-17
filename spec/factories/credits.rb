FactoryBot.define do
  factory :credit do
    url { Faker::Internet.url }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end
