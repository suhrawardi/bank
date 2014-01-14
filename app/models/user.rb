class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :account, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  after_create :open_bank_account

protected

  def open_bank_account
    Account.create!(balance: 100, user: self)
  end
end
