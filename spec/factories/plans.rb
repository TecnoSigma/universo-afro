FactoryBot.define do
  factory :plan do
    name { Faker::Lorem.word  }

    trait :pendent do
      status { Statuses::PLAN[:pendent] }
    end

    trait :activated do
      status { Statuses::PLAN[:activated] }
    end

    trait :deactivated do
      status { Statuses::PLAN[:deactivated] }
    end

    trait :cancelled do
      status { Statuses::PLAN[:cancelled] }
    end
  end
end
