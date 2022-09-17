require 'rails_helper'

RSpec.describe Jobber, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass first name' do
      jobber = FactoryBot.build(:jobber, first_name: nil)

      expect(jobber).to be_invalid
      expect(jobber.errors.messages[:first_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass last name' do
      jobber = FactoryBot.build(:jobber, last_name: nil)

      expect(jobber).to be_invalid
      expect(jobber.errors.messages[:last_name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass afro ID' do
      jobber = FactoryBot.build(:jobber, afro_id: nil)

      expect(jobber).to be_invalid
      expect(jobber.errors.messages[:afro_id]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass status' do
      jobber = FactoryBot.build(:jobber, status: nil)

      expect(jobber).to be_invalid
      expect(jobber.errors.messages[:status]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'vailidates relationships' do
    it 'validates relationship 1:1 between Jobber and Avatar' do
      jobber = Jobber.new

      expect(jobber).to respond_to(:avatar)
    end
  end
end
