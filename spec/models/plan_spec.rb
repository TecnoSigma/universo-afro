require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'validates presence' do
    it 'no validates when no pass name' do
      plan = FactoryBot.build(:plan, name: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:name]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass reference' do
      plan = FactoryBot.build(:plan, reference: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:reference]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass price' do
      plan = FactoryBot.build(:plan, price: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:price]).to include('Preenchimento de campo obrigatório!')
    end

    it 'no validates when no pass status' do
      plan = FactoryBot.build(:plan, status: nil)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:status]).to include('Preenchimento de campo obrigatório!')
    end
  end

  describe 'validates price' do
    it 'no validates price when is zero' do
      plan = FactoryBot.build(:plan, price: 0.0)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:price]).to include('Formato inválido!')
    end

    it 'no validates price when is negative' do
      plan = FactoryBot.build(:plan, price: -10.50)

      expect(plan).to be_invalid
      expect(plan.errors.messages[:price]).to include('Formato inválido!')
    end
  end

  describe 'validates status' do
    it 'no validates when status is invalid' do
      plan = Plan.new

      expect do
        plan.status = 'invalid_status'
      end.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
    end
  end

  describe 'validates uniqueness' do
    it 'no validates when name is duplicated' do
      plan1 = FactoryBot.create(:plan, :activated)
      plan2 = FactoryBot.build(:plan, :activated, name: plan1.name)

      expect(plan2).to be_invalid
      expect(plan2.errors.messages[:name]).to include('Dado já utilizado!')
    end
  end

  describe '.persist!' do
    context 'when plan is created in payment gateway' do
      it 'creates a new plan' do
        gateway_code = SecureRandom.hex(32).upcase
        name = 'Plano Basic'
        reference = 'basic'
        price = 20.99

        allow(Financial::CreatePlanJob).to receive(:perform_now) { gateway_code }

        result1 = described_class.persist!(name: name, reference: reference, price: price)
        result2 = Plan.find_by_code(gateway_code)

        expect(result1).to eq(true)
        expect(result2).to be_present
      end
    end

    context 'when plan isn\'t created in payment gateway' do
      it 'no creates a new plan' do
        name = 'Plano Basic'
        reference = 'basic'
        price = 20.99

        allow(Financial::CreatePlanJob).to receive(:perform_now) { '' }

        result1 = described_class.persist!(name: name, reference: reference, price: price)
        result2 = Plan.find_by_reference(reference)

        expect(result1).to eq(false)
        expect(result2).to be_nil
      end
    end
  end
end
