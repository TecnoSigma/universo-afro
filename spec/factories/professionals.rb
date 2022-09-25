FactoryBot.define do
  factory :professional do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    cpf { Faker::Base.regexify('\d{3}.\d{3}.\d{3}-\d{2}') }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    address { Faker::Address.street_name }
    number { Faker::Address.building_number }
    complement { %w[casa fundos].sample }
    district { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state }
    postal_code { Faker::Base.regexify('\d{5}-\d{3}') }
    remote { false }

    trait :pendent do
      status { Statuses::PROFESSIONAL[:pendent] }
    end

    trait :activated do
      status { Statuses::PROFESSIONAL[:activated] }
    end

    trait :deactivated do
      status { Statuses::PROFESSIONAL[:deactivated] }
    end

    trait :cancelled do
      status { Statuses::PROFESSIONAL[:cancelled] }
    end
  end
end
