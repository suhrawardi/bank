class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount, null: false, default: 0
      t.integer :source_id
      t.integer :destination_id
      t.string :status
      t.text :msg
      t.timestamps
    end
  end
end
