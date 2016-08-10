require 'date'

class Account
  attr_accessor :person, :account_status, :balance, :exp_date, :owner, :name
  attr_reader :pin_code
  STANDARD_VALIDITY_YRS = 5

  def initialize(attrs = {})
    @owner = set_owner(attrs[:owner])
    @account_status = :active
    @pin_code = randomize_pin_code
    @balance = 0
    @exp_date = set_expire_date
  end

  def account_has_an_person?(person)
    @person
  end

  def pin_code_is_correct?(pin_code)
    @pin_code
  end

  def account_is_active?()
    @account_status
  end

  def account_has_balance?(balance)
    @balance
  end

  def exp_date_is_before_today?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def randomize_pin_code
    rand(1000..9999)
  end

  def set_expire_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  def deactivate
    @account_status = :disabled
  end

  private

  def set_owner(obj)
    obj == nil ? missing_owner : obj
  end

  # def set_name(obj)
  #   obj[:name] == nil ? missing_name : obj
  # end

  def missing_owner
    raise 'An account owner is required'
  end
  #
  # def missing_name
  #   raise 'This account has no associated name'
  # end

end
