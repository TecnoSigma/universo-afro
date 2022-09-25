require 'rails_helper'

RSpec.describe Professional, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass first name' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, first_name: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:first_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass last name' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, last_name: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:last_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass CPF' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, cpf: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:cpf]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass email' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, email: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:email]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass password' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, password: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:password]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass address' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, address: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:address]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass number' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, number: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:number]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass district' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, district: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:district]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass city' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, city: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:city]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass state' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, state: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:state]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass postal code' do
      profession = FactoryBot.create(:profession)
      professional = FactoryBot.build(:professional, postal_code: nil, profession: profession)

      expect(professional).to be_invalid
      expect(professional.errors.messages[:postal_code]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates uniqueness' do
    it 'no validates when CPF is duplicated' do
      profession = FactoryBot.create(:profession)
      professional1 = FactoryBot.create(:professional, profession: profession)
      professional2 = FactoryBot.build(:professional, cpf: professional1.cpf, profession: profession)

      expect(professional2).to be_invalid
      expect(professional2.errors.messages[:cpf]).to include('Dado já utilizado!')
    end
  end

  describe 'validates relationships' do
    it 'validates relationship between Professional and Profession' do
      professional = described_class.new

      expect(professional). to respond_to(:profession)
    end
  end
end
