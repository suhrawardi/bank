require 'spec_helper'

describe Transaction do

  subject do
    build(:transaction)
  end

  context 'validations' do

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'is not valid with an incorrect status' do
      subject.status = :something
      expect(subject).not_to be_valid
    end
  end

  context 'associations' do

    it 'has a source account' do
      expect(subject).to respond_to(:source)
    end

    it 'has a destination account' do
      expect(subject).to respond_to(:destination)
    end
  end

  context '#for_account' do

    subject(:account) do
      create(:account)
    end

    subject(:with_source_account) do
      Transaction.create!(source: account, status: :failed)
    end

    subject(:with_destination_account) do
      Transaction.create!(destination: account, status: :failed)
    end

    subject(:with_another_account) do
      Transaction.create!(status: :failed)
    end

    let(:transactions) do
      Transaction.for_account(account)
    end

    it 'finds the transaction with the source account' do
      expect(transactions).to include(with_source_account)
    end

    it 'finds the transaction with the destination account' do
      expect(transactions).to include(with_destination_account)
    end

    it 'does not find the transaction with another account' do
      expect(transactions).not_to include(with_another_account)
    end
  end
end
