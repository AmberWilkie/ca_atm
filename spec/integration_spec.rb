require './lib/person.rb'

describe 'a person uses his account to access the atm' do
  it 'allows a withdrawal by a person' do
    amber = Person.new(cash:100, name: "Amber")
    atm = Atm.new
    amber.create_account
    amber.deposit(100)
    amber.withdraw_from_atm(amount:50, account: amber.account, pin: amber.account.pin_code, atm: atm)
    expect(atm.funds).to eq 950
  end
end
