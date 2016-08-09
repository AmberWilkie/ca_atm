require 'account.rb'

class Person

  attr_accessor :name, :cash, :account
  @name = nil

  def initialize(attrs = {}) #it's not taking name: 'thomas' from the spec file and I don't know why. Works if I put name: 'thomas' in here.
    @name = attrs[:name]
    access_user_name(name)
    @cash = 100
    account_exists?(name)
  end

  def access_user_name(attrs = {})
    if name != nil
      @name = name
    else
      raise 'A name is required'
    end
  end

  def account_exists?(name)
    @account = Account.new(owner: name)
    #puts "Here is account: #{account}"

  end

  def create_account
  end

  def deposit(amount)
    # @cash >= @amount ? make_deposit(amount) : raise "You don't have the cash"
    puts "Here's cash: #{cash} and here's amount: #{amount}"
    if @cash >= amount #this should be true, why isn't it!?
      make_deposit(amount)
    else
      raise "You don't have the cash"
    end
  end

  def make_deposit(amount)
    @cash -= amount
    account.balance += amount
  end

end
