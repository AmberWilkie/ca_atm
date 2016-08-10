require './lib/account.rb'
require './lib/atm.rb'
require 'pry'

class Person

  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = set_name(attrs)
    attrs[:cash] == nil ? @cash = 0 : @cash = attrs[:cash]
    # @cash = set_cash(attrs) || 0
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def deposit(amount)
     if @cash >= amount
       perform_deposit(amount)
     else
       'You have no cash'
      #  raise "You don't have the cash"
     end
  end

  def withdraw_from_atm(args = {})
    args[:atm] == nil ? missing_atm : atm = args[:atm]
    account = @account
    amount = args[:amount]
    pin = args[:pin]
    atm.withdraw(account: account, amount: amount, pin_code: pin)
  end

  private
  def perform_deposit(amount)
    if @account == nil
      raise RuntimeError, 'No account present'
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

  # def set_cash(attrs)
  #   if attrs[:cash] == nil
  #     raise 'You have no cash'
  #   else
  #     attrs[:cash]
  #   end
  # end

  def missing_atm
    raise RuntimeError, 'An ATM is required'
  end

end
