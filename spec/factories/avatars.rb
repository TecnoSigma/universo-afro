FactoryBot.define do
  factory :avatar do
    name { Faker::Lorem.word }
    data { SecureRandom.hex(40) }
    filename { Faker::File.file_name(dir: 'path/to') }
    mime_type { Faker::File.mime_type(media_type: 'image') }
  end
end
