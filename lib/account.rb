require 'date'

class Account
  attr_accessor :owner, :account_status, :balance, :exp_date
  attr_reader :pin_code
  STANDARD_VALIDITY_YRS = 5

  def initialize()
    @account_status = 'active'
    randomize_pin_code #set pin_code
    @balance = 100
    set_expire_date #set exp_date
  end

  def account_has_an_owner?(owner)
    @owner
  end

  def pin_code_is_correct?(pin_code)
    @pin_code
  end

  def account_is_active?(account_status)
    @account_status
  end

  def account_has_balance?(balance)
    @balance
  end

  def exp_date_is_before_today?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def randomize_pin_code
    @pin_code = rand(1000..9999)
  end

  def set_expire_date
    @exp_date = Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end


end
