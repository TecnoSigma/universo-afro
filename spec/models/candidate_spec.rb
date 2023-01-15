require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass first name' do
      candidate = FactoryBot.build(:candidate, first_name: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:first_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass last name' do
      candidate = FactoryBot.build(:candidate, last_name: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:last_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass email' do
      candidate = FactoryBot.build(:candidate, email: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:email]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass password' do
      candidate = FactoryBot.build(:candidate, password: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:password]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass state' do
      candidate = FactoryBot.build(:candidate, state: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass city' do
      candidate = FactoryBot.build(:candidate, city: nil)

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:city]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates avatar' do
    it 'attaches default avatar when no pass avatar' do
      candidate = FactoryBot.build(:candidate)
      candidate.avatar = nil
      candidate.save!

      result = Candidate.find_by(id: candidate.id).avatar.blob.filename.to_s

      expected_result = 'default_avatar.png'

      expect(result).to eq(expected_result)
    end

    it 'no validates when avatar have invalid size' do
      candidate = FactoryBot.build(:candidate)
      candidate.avatar.attach(io: File.open('spec/fixtures/big_avatar.jpg'), filename: 'big_avatar.jpg')

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:avatar]).to include('Imagem muito grande!')
    end

    it 'no validates when avatar have invalid type' do
      candidate = FactoryBot.build(:candidate)
      candidate.avatar.attach(io: File.open('spec/fixtures/avatar.txt'), filename: 'avatar.txt')

      expect(candidate).to be_invalid
      expect(candidate.errors.messages[:avatar]).to include('Tipo de imagem inválido!')
    end
  end

  it 'no validates when status is invalid' do
    candidate = Candidate.new

    expect do
      candidate.status = 'invalid_status'
    end.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
  end

  it 'generates afro ID when a nem candidate is created' do
    candidate = FactoryBot.build(:candidate, afro_id: nil)
    candidate.save!

    result = candidate.afro_id

    expect(result).to be_present
  end

  describe 'validates uniqueness' do
    it 'no validates when email is duplicated' do
      candidate1 = FactoryBot.create(:candidate)
      candidate2 = FactoryBot.build(:candidate, email: candidate1.email)

      expect(candidate2).to be_invalid
      expect(candidate2.errors.messages[:email]).to include('Dado já utilizado!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship 1:1 between Candidate and Avatar' do
      candidate = described_class.new

      expect(candidate).to respond_to(:avatar)
    end

    it 'validates relationship 1:N between Candidate and CandidateVacantJob' do
      candidate = described_class.new

      expect(candidate).to respond_to(:candidate_vacant_jobs)
    end
  end

  describe '.find_by_resource' do
    it 'shows candidate by resource when pass valid resource' do
      first_name = 'João'
      last_name = 'Silva'

      resource = 'joao-silva'

      candidate = FactoryBot.create(:candidate, first_name: first_name, last_name: last_name)

      result = Candidate.find_by_resource(resource)

      expect(result).to eq(candidate)
    end

    it 'returns empty value when pass invalid resource' do
      resource = 'joao-silva'

      result = Candidate.find_by_resource(resource)

      expect(result).to be_nil
    end
  end

  describe '#fullname' do
    it 'returns candidate fullname' do
      first_name = 'João'
      last_name = 'Silva'

      user = FactoryBot.create(:candidate, first_name: first_name, last_name: last_name)

      expected_result = "#{first_name} #{last_name}"

      result = user.fullname

      expect(result).to eq(expected_result)
    end
  end

  describe '#available_vacant_jobs' do
    it 'returns list containing only available vacant jobs that the candidate choosen' do
      profession1 = FactoryBot.create(:profession, name: 'Medico')
      profession2 = FactoryBot.create(:profession, name: 'Advogado')

      company1 = FactoryBot.create(:company, status: 'activated')
      company2 = FactoryBot.create(:company, status: 'activated')

      candidate = FactoryBot.create(:candidate, status: 'activated')

      candidate_vacant_job1 = FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession1)
      candidate_vacant_job2 = FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession2)

      company_vacant_job_attributes1 = FactoryBot.attributes_for(:vacant_job, :company_vacant_job, company_id: company1.id, profession: profession1, vacant_job_id: nil)
      company_vacant_job_attributes2 = FactoryBot.attributes_for(:vacant_job, :company_vacant_job, company_id: company2.id, profession: profession2, vacant_job_id: nil)

      company_vacant_job1 = CompanyVacantJob.create(company_vacant_job_attributes1)
      company_vacant_job2 = CompanyVacantJob.create(company_vacant_job_attributes2)

      result = candidate.available_vacant_jobs

      expected_result = [VacantJob.find_by_id(company_vacant_job2.id), VacantJob.find_by_id(company_vacant_job1.id)]

      expect(result).to eq(expected_result)
    end

    it 'returns empty list when candaite not choosen the vacant job available by company' do
      profession1 = FactoryBot.create(:profession, name: 'Medico')
      profession2 = FactoryBot.create(:profession, name: 'Advogado')
      profession3 = FactoryBot.create(:profession, name: 'Agrônomo')

      company = FactoryBot.create(:company, status: 'activated')

      candidate = FactoryBot.create(:candidate, status: 'activated')

      candidate_vacant_job1 = FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession1)
      candidate_vacant_job2 = FactoryBot.create(:vacant_job, :candidate_vacant_job, candidate_id: candidate.id, profession: profession2)

      FactoryBot.create(:vacant_job, :company_vacant_job, company_id: company.id, profession: profession3)

      result = candidate.available_vacant_jobs

      expect(result).to be_empty
    end
  end
end
