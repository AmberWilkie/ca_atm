require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(attrs = {})
    account = attrs[:account]
    @account_status = attrs[:account_status] || :active

    case
    when incorrect_pin?(attrs[:pin_code], account.pin_code) then
      receipt_message('wrong pin')
    when card_expired?(account.exp_date) then
      receipt_message('card expired')
    when account_inactive?(@account_status) then
      receipt_message('account disabled')
    when insufficient_funds_in_account?(attrs[:amount], attrs[:account]) then
      receipt_message('insufficient funds')
    when insufficient_funds_in_atm?(attrs[:amount]) then
      receipt_message('insufficient funds in ATM')
    else
      perform_transaction(attrs[:amount], attrs[:account], attrs[:account_status])
    end
  end

  def perform_transaction(amount, account, account_status)
    @funds -= amount
    account.balance -= amount
    receipt_message_success('success', amount)
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

  def receipt_message_success(message_success, amount)
    { status: true, message: message_success, date: Date.today, account_status: @account_status, amount: amount, bills: add_bills(amount) }
  end
end
