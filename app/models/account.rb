class Account < ActiveRecord::Base

  INITIAL_BALANCE = 100

  belongs_to :user

  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  before_create :initialize_balance

  def transactions
    Transaction.for_account(self)
  end

protected

  def initialize_balance
    self.balance = INITIAL_BALANCE
  end

end
