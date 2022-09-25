FactoryBot.define do
  factory :vacant_job do
    name { Faker::Lorem.word }
    category { Faker::Lorem.word }
    state { Faker::Address.state }
    city { Faker::Address.city }

    trait :alert do
      vacancy_alert { true }
    end

    trait :remote do
      remote_job { true }
    end
  end
end
