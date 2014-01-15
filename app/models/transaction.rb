class Transaction < ActiveRecord::Base

  belongs_to :source, class_name: 'Account'
  belongs_to :destination, class_name: 'Account'

  validates :status, inclusion: { in: %i(success danger) }

  default_scope -> { order('created_at DESC') }

  scope :for_account, ->(account) {
    where('source_id = ? OR destination_id = ?', account.id, account.id)
  }
end
