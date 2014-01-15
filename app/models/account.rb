class Account < ActiveRecord::Base

  INITIAL_BALANCE = 100

  belongs_to :user

  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :initialize_balance

protected

  def initialize_balance
    self.balance = INITIAL_BALANCE
  end

end
