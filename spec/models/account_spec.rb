require 'spec_helper'

describe Account do

  context 'validations' do

    subject do
      build(:account)
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'is not valid without a balance' do
      subject.balance = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a balance below zero' do
      subject.balance = -2
      expect(subject).not_to be_valid
    end
  end

  context 'after initialization' do

    subject do
      Account.new
    end

    it 'has a 100 euro balance' do
      expect(subject.balance).to eq(100)
    end
  end
end
