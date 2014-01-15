require 'spec_helper'

class Account::IncreaseDestination < DCI::Context
  role destination_account: Account::Deposit

  def initialize(destination_account)
    self.destination_account = destination_account
  end

  def transfer(amount)
    roles.each{ |role| role.transfer(amount) }
  end
end

describe Account::Deposit do

  context 'transfer' do

    subject(:account) do
      create(:account)
    end

    it 'receives a given amount' do
      Account::IncreaseDestination.new(subject).transfer(13)
      expect(subject.balance).to eq(113)
    end
  end
end
