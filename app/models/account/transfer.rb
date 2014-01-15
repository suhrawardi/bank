class Account::Transfer < DCI::Context

  attr_reader :source, :destination

  role source_account: Account::Withdraw
  role destination_account: Account::Deposit

  def initialize(source, destination)
    if source.nil? or destination.nil?
      raise ActiveRecord::RecordNotFound, 'User not found'
    end
    self.source_account = @source = source.account
    self.destination_account = @destination = destination.account
  end

  def transfer(amount)
    ActiveRecord::Base.transaction do
      roles.each{ |role| role.transfer(amount.to_i) }
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
