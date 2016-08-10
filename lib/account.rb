require 'date'

class Account
  attr_accessor :person, :account_status, :balance, :owner, :name
  attr_reader :pin_code, :exp_date
  STANDARD_VALIDITY_YRS = 5

  def initialize(attrs = {})
    @owner = set_owner(attrs[:owner])
    @account_status = :active
    @pin_code = randomize_pin_code
    @balance = 0
    @exp_date = set_expire_date
  end

  def randomize_pin_code
    rand(1000..9999)
  end

  def set_expire_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  # We never use this class but it certainly seems like something or other should disable
  # an account if there's a problem.
  # That is, I could delete it in refactor but I'm leaving it in anyway.
  def deactivate
    @account_status = :disabled
  end

  private

  def set_owner(obj)
    obj == nil ? missing_owner : obj
  end

  def missing_owner
    raise 'An account owner is required'
  end
end
