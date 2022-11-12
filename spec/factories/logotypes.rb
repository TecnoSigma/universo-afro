FactoryBot.define do
  factory :logotype do
    data { SecureRandom.hex(40) }
    filename { "#{Faker::Lorem.word}.png" }
    mime_type { Faker::File.mime_type(media_type: 'image') }
  end
end
