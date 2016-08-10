require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(attrs = {})
    account = attrs[:account]
    @account_status = attrs[:account_status] || :active
    # binding.pry
    case
    when incorrect_pin?(attrs[:pin_code], account.pin_code) then
      error_message = 'wrong pin'
      receipt_message(error_message)
    when card_expired?(account.exp_date) then
      error_message = 'card expired'
      receipt_message(error_message)
    when account_inactive?(@account_status) then
      error_message = 'account disabled'
      receipt_message(error_message)
    when insufficient_funds_in_account?(attrs[:amount], attrs[:account]) then
      error_message = 'insufficient funds'
      receipt_message(error_message)
    when insufficient_funds_in_atm?(attrs[:amount]) then
      error_message = 'insufficient funds in ATM'
      receipt_message(error_message)
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
    raise 'You entered no pin'
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

  def receipt_message(message_error)
    { status: false, message: message_error, date: Date.today, account_status: @account_status }
  end
end
