FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    nickname { name.split.first }
    cnpj { Faker::Company.brazilian_company_number(formatted: true) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    address { Faker::Address.street_name }
    number { Faker::Address.building_number }
    complement { %w[casa fundos].sample }
    district { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state }
    postal_code { Faker::Base.regexify('\d{5}-\d{3}') }

    after(:build) do |company|
      company.avatar.attach(io: File.open('spec/fixtures/avatar.png'), filename: 'avatar.png')
    end

    trait :pendent do
      status { Statuses::COMPANY[:pendent] }
    end

    trait :activated do
      status { Statuses::COMPANY[:activated] }
    end

    trait :deactivated do
      status { Statuses::COMPANY[:deactivated] }
    end

    trait :cancelled do
      status { Statuses::COMPANY[:cancelled] }
    end
  end
end
