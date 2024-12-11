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

Credit.create(url: 'https://www.flaticon.com/br/icones-gratis/do-utilizador',
              title: 'user',
              description: 'User icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/br/icones-gratis/companhia',
              title: 'company',
              description: 'User icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/br/icones-gratis/contrato',
              title: 'contract',
              description: 'User icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/br/icones-gratis/clipe-de-papel',
              title: 'paperclip',
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
  company3 = FactoryBot.create(:company, status: 'activated', email: 'tecnooxossi@gmail.com')

  # Create candidate vacant jobs
  vacant_job1 = FactoryBot.attributes_for(:vacant_job, details: 'Any text 1', remote: false, alert: false)
  vacant_job2 = FactoryBot.attributes_for(:vacant_job, details: 'Any text 2', remote: false, alert: false)
  vacant_job3 = FactoryBot.attributes_for(:vacant_job, details: 'Any text 3', remote: false, alert: false)

  candidate_vacant_job1 = CandidateVacantJob.new(vacant_job1)
  candidate_vacant_job1.profession = profession1
  candidate_vacant_job1.candidate = candidate
  candidate_vacant_job1.save!

  candidate_vacant_job2 = CandidateVacantJob.new(vacant_job2)
  candidate_vacant_job2.profession = profession2
  candidate_vacant_job2.candidate = candidate
  candidate_vacant_job2.save!

  candidate_vacant_job3 = CandidateVacantJob.new(vacant_job3)
  candidate_vacant_job3.profession = profession2
  candidate_vacant_job3.candidate = Candidate.first
  candidate_vacant_job3.save!

  # Create company vacant jobs
  vacant_job4 = FactoryBot.attributes_for(:vacant_job, details: 'Any text 4', remote: false, alert: false)
  vacant_job5 = FactoryBot.attributes_for(:vacant_job, details: 'Any text 5', remote: false, alert: false)

  company_vacant_job1 = CompanyVacantJob.new(vacant_job4)
  company_vacant_job1.profession = profession1
  company_vacant_job1.company = company1
  company_vacant_job1.save!

  company_vacant_job2 = CompanyVacantJob.new(vacant_job5)
  company_vacant_job2.profession = profession2
  company_vacant_job2.company = company2
  company_vacant_job2.save!

  # Create candidatures
  Candidature.create(company_vacant_job: company_vacant_job1, candidate_vacant_job: candidate_vacant_job1)
  Candidature.create(company_vacant_job: company_vacant_job2, candidate_vacant_job: candidate_vacant_job2)
  Candidature.create(company_vacant_job: company_vacant_job2, candidate_vacant_job: candidate_vacant_job3)
end


