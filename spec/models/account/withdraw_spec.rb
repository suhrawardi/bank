require 'spec_helper'

class Account::DecreaseSource < DCI::Context
  role source_account: Account::Withdraw

  def initialize(source_account)
    self.source_account = source_account
  end

  def transfer(amount)
    roles.each{ |role| role.transfer(amount) }
  end
end

describe Account::Withdraw do

  context 'transfer' do

    subject(:account) do
      create(:account)
    end

    it 'withdraws a given amount' do
      Account::DecreaseSource.new(subject).transfer(63)
      expect(subject.balance).to eq(37)
    end
  end
end
