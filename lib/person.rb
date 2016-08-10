require './lib/account.rb'
require './lib/atm.rb'

class Person

  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = set_name(attrs)
    attrs[:cash] == nil ? @cash = 0 : @cash = attrs[:cash]
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def deposit(amount)
     @cash >= amount ? perform_deposit(amount) : raise_no_cash_error
  end

  def withdraw_from_atm(args = {})
    args[:atm] == nil ? missing_atm : atm = args[:atm]
    atm.withdraw(account: @account, amount: args[:amount], pin_code: args[:pin])
  end

  private
  def perform_deposit(amount)
    if @account == nil
      no_account_error
    else
    @cash -= amount
    account.balance += amount
    end
  end

  def set_name(attrs)
    if attrs[:name] == nil
      raise 'A name is required'
    else
      attrs[:name]
    end
  end

  def missing_atm
    raise RuntimeError, 'An ATM is required'
  end

  def raise_no_cash_error
    raise 'You have no cash'
  end

  def no_account_error
    raise RuntimeError, 'No account present'
  end

end
