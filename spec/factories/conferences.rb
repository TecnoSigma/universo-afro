FactoryBot.define do
  factory :conference do
    date { '12/12/2050' }
    horary { '14:00' }
    afro_id { SecureRandom.hex(10) }

    trait :pendent do
      status { Statuses::CONFERENCE[:pendent] }
    end

    trait :accepted do
      status { Statuses::CONFERENCE[:accepted] }
    end

    trait :refused do
      status { Statuses::CONFERENCE[:refused] }
    end

    trait :cancelled do
      status { Statuses::CONFERENCE[:cancelled] }
    end
  end
end
