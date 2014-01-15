class Account::Withdraw < DCI::Role

  def transfer(amount)
    decrement(:balance, amount)
    save!
  end

end
