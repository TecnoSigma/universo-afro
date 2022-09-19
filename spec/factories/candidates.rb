FactoryBot.define do
  factory :candidate do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
    state { Faker::Address.state }
    city { Faker::Address.city }
    afro_id { SecureRandom.hex(10) }

    trait :pendent do
      status { Statuses::CANDIDATE[:pendent] }
    end

    trait :activated do
      status { Statuses::CANDIDATE[:activated] }
    end

    trait :deactivated do
      status { Statuses::CANDIDATE[:deactivated] }
    end

    trait :cancelled do
      status { Statuses::CANDIDATE[:cancelled] }
    end
  end
end
