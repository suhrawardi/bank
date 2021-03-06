class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :account, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  after_create :create_account

  scope :named, ->(name) { where(name: name) }

  def self.by_name(name)
    self.named(name).first
  end

end
