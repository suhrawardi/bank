class Account::Transfer < DCI::Context

  role source_account: Account::Withdraw
  role destination_account: Account::Deposit

  def initialize(source_account, destination_account)
    self.source_account = source_account
    self.destination_account = destination_account
  end

  def transfer(amount)
    ActiveRecord::Base.transaction do
      roles.each{ |role| role.transfer(amount) }
    end
  end
end
