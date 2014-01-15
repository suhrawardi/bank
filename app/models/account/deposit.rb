class Account::Deposit < DCI::Role

  def transfer(amount)
    increment(:balance, amount)
    save!
  end

end
