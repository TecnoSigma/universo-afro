FactoryBot.define do
  factory :vacant_job do
    name { Faker::Lorem.word }
    kind { Faker::Lorem.word }
    state { Faker::Address.state }
    city { Faker::Address.city }

    trait :candidate do
      creator { 1 }
    end

    trait :company do
      creator { 2 }
    end

    trait :alert do
      vacancy_alert { true }
    end

    trait :remote do
      remote_job { true }
    end
  end
end
