FactoryBot.define do
  factory :candidate do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    state { Faker::Address.state }
    city { Faker::Address.city }
    afro_id { SecureRandom.hex(10) }

    after(:build) do |candidate|
      candidate.avatar.attach(io: File.open('spec/fixtures/avatar.png'), filename: 'avatar.png')
    end

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
