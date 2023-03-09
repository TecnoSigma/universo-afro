FactoryBot.define do
  factory :plan do
    name { Faker::Lorem.word }
    reference { Faker::Lorem.word }
    price { Faker::Number.decimal(l_digits: 2) }

    trait :activated do
      status { :activated }
    end

    trait :deactivated do
      status { :deactivated }
    end

    trait :cancelled do
      status { :expected }
    end
  end
end
