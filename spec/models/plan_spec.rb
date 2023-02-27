require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      plan = FactoryBot.build(:plan, name: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass status' do
      plan = FactoryBot.build(:plan, status: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:status]).to include('Preenchimento de campo obrigatório!')
    end
  end

  it 'no validates when status is invalid' do
    plan = Plan.new

    expect do
      plan.status = 'invalid_status'
    end.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
  end

  describe 'validates uniqueness' do
    it 'no validates when name is duplicated' do
      plan1 = FactoryBot.create(:plan, :activated)
      plan2 = FactoryBot.build(:plan, :activated, name: plan1.name)

      expect(plan2).to be_invalid
      expect(plan2.errors.messages[:name]).to include('Dado já utilizado!')
    end
  end
end
