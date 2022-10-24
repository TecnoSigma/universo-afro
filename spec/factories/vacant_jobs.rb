FactoryBot.define do
  factory :vacant_job do
    category { Faker::Lorem.word }
    state { Faker::Address.state }
    city { Faker::Address.city }

    trait :alert do
      vacancy_alert { true }
    end

    trait :remote do
      remote_job { true }
    end

    trait :candidate_vacant_job do
      type { 'CandidateVacantJob' }
    end

    trait :company_vacant_job do
      type { 'CompanyVacantJob' }
    end
  end
end
