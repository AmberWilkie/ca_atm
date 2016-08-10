require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(attrs = {})
    # amount, pin_code, account, account_status)
    account = attrs[:account]
    account_status = attrs[:account_status] || :active
    case
    when incorrect_pin?(attrs[:pin_code], account.pin_code) then
      { status: false, message: 'wrong pin', date: Date.today, account_status: account_status }
    when card_expired?(account.exp_date) then
      { status: false, message: 'card expired', date: Date.today, account: account_status }
    when account_inactive?(account_status) then
      { status: false, message: 'account disabled', date: Date.today, account: account_status }
    when insufficient_funds_in_account?(attrs[:amount], attrs[:account]) then
      { status: true, message: 'insufficient funds', date: Date.today, account: account_status }
    when insufficient_funds_in_atm?(attrs[:amount]) then
      { status: false, message: 'insufficient funds in ATM', date: Date.today, account: account_status }
    else
      perform_transaction(attrs[:amount], attrs[:account], attrs[:account_status])
    end
  end

  def perform_transaction(amount, account, account_status)
    @funds -= amount
    account.balance -= amount
    expected_output = { status: true, message: 'success', date: Date.today, amount: amount, account: account_status, bills: add_bills(amount) }
  end

  private
  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end

  def insufficient_funds_in_atm?(amount)
    amount > @funds
  end

  def incorrect_pin?(pin_code, actual_pin)
    pin_code == nil ? missing_pin : pin_code != actual_pin
  end

  def missing_pin
    raise_error 'You entered no pin'
  end

  def card_expired?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def account_inactive?(account_status)
    account_status == :disabled
  end

  def add_bills(amount)
    denominations = [20, 10, 5]
    bills = []
    denominations.each do |x|
      while amount - x >= 0
        amount -= x
        bills << x
      end
    end
    bills
  end
end
