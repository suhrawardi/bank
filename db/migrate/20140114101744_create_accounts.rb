class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :balance, null: false, default: 0
      t.timestamps
    end
  end
end
