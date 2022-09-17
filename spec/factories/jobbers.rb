FactoryBot.define do
  factory :jobber do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
    afro_id { SecureRandom.hex(10) }

    trait :pendent do
      status { Statuses::JOBBER[:pendent] }
    end

    trait :activated do
      status { Statuses::JOBBER[:activated] }
    end

    trait :deactivated do
      status { Statuses::JOBBER[:deactivated] }
    end

    trait :cancelled do
      status { Statuses::JOBBER[:cancelled] }
    end
  end
end
