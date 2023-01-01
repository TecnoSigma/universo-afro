# frozen_string_literal: true

# Create image credits (copyright)
Credit.create(url: 'https://www.flaticon.com/free-icons/building',
              title: 'building icons',
              description: 'Building icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/long-hair',
              title: 'long hair icons',
              description: 'Long hair icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/surgeon',
              title: 'surgeon icons',
              description: 'Surgeon icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.freepik.com/free-vector/simple-background-with-geometric-elements_17665233.htm#&position=0&from_view=collections',
              title: 'Image by visnezh on Freepik',
              description: 'Image by visnezh on Freepik')

Credit.create(url: 'https://www.flaticon.com/free-icons/add-photo',
              'title': 'add photo icons',
              description: 'Add photo icons created by Tanah Basah - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/add-image',
              title: 'add-image icons',
              description: 'Add-image icons created by nawicon - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/user',
              title: 'user icons',
              description: 'User icons created by Freepik - Flaticon')

# Create States and Cities
Tasks::PlacesGenerator.call!
# State.create(name: 'São Paulo', external_id: 1)
# State.create(name: 'Minas Gerais', external_id: 2)

# City.create(name: 'Mauá', state: State.first)
# City.create(name: 'Belo Horizonte', state: State.last)

Tasks::ProfessionsGenerator.call!

if Rails.env.production?
  # Create Professions
  Tasks::ProfessionsGenerator.call!
  # Profession.create(name: 'Arquivista')
  # Profession.create(name: 'Office-Boy')
end

unless Rails.env.production?
  # Create candidates
  FactoryBot.create_list(:candidate, 5, :activated)
  candidate = Candidate.create(
    first_name: 'Alexandre',
    last_name: 'Martins',
    email: 'tecnooxossi@gmail.com',
    password: 'oxossi12',
    state: 'São Paulo',
    city: 'São Paulo',
    ethnicity_self_declaration: true,
    afro_id: 'c97e9c6ff50afdd48a69',
    status: 'activated'
  )

  # Create professions
  profession1 = FactoryBot.create(:profession, name: 'Advogado')
  profession2 = FactoryBot.create(:profession, name: 'Engenheiro')

  # Create companies
  company1 = FactoryBot.create(:company, status: 'activated')
  company2 = FactoryBot.create(:company, status: 'activated')

  # Create candidate vacant jobs
  FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession1)
  FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession2)
  FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: Candidate.first.id, profession: profession2)

  # Create company vacant jobs
  FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company1.id, profession: profession1, availabled_quantity: 3, filled_quantity: 1, vacant_job_id: SecureRandom.hex(10))
  FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company2.id, profession: profession2, availabled_quantity: 5, filled_quantity: 2, vacant_job_id: SecureRandom.hex(10))
end
