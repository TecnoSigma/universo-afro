require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      company = FactoryBot.build(:company, name: nil, nickname: 'Anything')

      expect(company).to be_invalid
      expect(company.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass nickname' do
      company = FactoryBot.build(:company, nickname: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:nickname]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass CNPJ' do
      company = FactoryBot.build(:company, cnpj: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:cnpj]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass email' do
      company = FactoryBot.build(:company, email: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:email]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass password' do
      company = FactoryBot.build(:company, password: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:password]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass address' do
      company = FactoryBot.build(:company, address: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:address]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass number' do
      company = FactoryBot.build(:company, number: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:number]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass district' do
      company = FactoryBot.build(:company, district: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:district]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass city' do
      company = FactoryBot.build(:company, city: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:city]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass state' do
      company = FactoryBot.build(:company, state: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass postal code' do
      company = FactoryBot.build(:company, postal_code: nil)

      expect(company).to be_invalid
      expect(company.errors.messages[:postal_code]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass avatar' do
      company = FactoryBot.build(:company)
      company.avatar = nil

      expect(company).to be_invalid
      expect(company.errors.messages[:avatar]).to include('Preenchimento de campo obrigatório!')
    end
  end

  it 'renames avatar name to same name that the afro ID' do
    company = FactoryBot.build(:company)
    company.avatar.attach(io: File.open('spec/fixtures/avatar.png'), filename: 'avatar.png')
    company.save

    result = Company.find_by(cnpj: company.cnpj).avatar.blob.filename.to_s

    expected_result = "#{company.afro_id}.png"

    expect(result).to eq(expected_result)
  end

  describe 'validates avatar' do
    it 'no validates when avatar have invalid size' do
      company = FactoryBot.build(:company)
      company.avatar.attach(io: File.open('spec/fixtures/big_avatar.jpg'), filename: 'big_avatar.jpg')

      expect(company).to be_invalid
      expect(company.errors.messages[:avatar]).to include('Imagem muito grande!')
    end

    it 'no validates when avatar have invalid type' do
      company = FactoryBot.build(:company)
      company.avatar.attach(io: File.open('spec/fixtures/avatar.txt'), filename: 'avatar.txt')

      expect(company).to be_invalid
      expect(company.errors.messages[:avatar]).to include('Tipo de imagem inválido!')
    end
  end

  describe 'validates uniqueness' do
    it 'no validates when CNPJ is duplicated' do
      company1 = FactoryBot.create(:company)
      company2 = FactoryBot.build(:company, cnpj: company1.cnpj)

      expect(company2).to be_invalid
      expect(company2.errors.messages[:cnpj]).to include('Dado já utilizado!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship between Company and CompanyVacantJob' do
      company = described_class.new

      expect(company). to respond_to(:company_vacant_jobs)
    end

    it 'validates relationship 1:N between Candidate and Conference' do
      company = described_class.new

      expect(company).to respond_to(:conferences)
    end
  end
end
