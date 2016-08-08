require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, account)
    case
    when insufficient_funds_in_account?(amount, account) then
      return
    else
      perform_transaction(amount, account)
    end
  end

  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end

  def perform_transaction(amount, account)
    @funds -= amount
    account.balance -= amount
    expected_output = { status: true, message: 'success', date: Date.today, amount: amount }
  end

end
