class Account::Transfer < DCI::Context

  attr_reader :source, :destination

  role source_account: Account::Withdraw
  role destination_account: Account::Deposit

  def initialize(source_account, destination_account)
    self.source_account = @source = source_account
    self.destination_account = @destination = destination_account
  end

  def transfer(amount)
    ActiveRecord::Base.transaction do
      roles.each{ |role| role.transfer(amount) }
      log(amount: amount, status: :success)
    end
  rescue
    log(amount: amount, status: :danger, msg: $!.to_s)
    raise $!
  end

private

  def log(args)
    Transaction.create!(args.merge!(source: source, destination: destination))
  end
end
