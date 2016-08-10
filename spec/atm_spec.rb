require './lib/atm.rb'

describe Atm do
  let(:account) { double('Account', pin_code: '1234', exp_date: '04/17', account_status: :active) }

  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
  end

  it 'has $1k on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'reduces funds at withdrawal' do
    subject.withdraw(amount: 50, pin_code: '1234', account: account, account_status: :active)
    expect(subject.funds).to eq 950
  end

  it 'allows withdrawal if account has the funds available' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 45, account: :active, bills: [20, 20, 5] }
    expect(subject.withdraw(amount: 45, pin_code: '1234', account: account, account_status: :active)).to eq expected_output
  end

  it 'rejects withdraw if account has insufficient funds' do
    expected_output = { status: false, message: 'insufficient funds', date: Date.today, account_status: :active }
    expect(subject.withdraw(amount: 105, pin_code: '1234', account: account, account_status: :active)).to eq expected_output
  end

  it 'rejects withdraw if ATM has insufficient funds' do
    subject.funds = 50
    expected_output = { status: false, message: 'insufficient funds in ATM', date: Date.today, account_status: :active }
    expect(subject.withdraw(amount: 100, pin_code: '1234', account: account, account_status: :active)).to eq expected_output
  end

  it 'rejects withdraw if pin is wrong' do
    expected_output = { status: false, message: 'wrong pin', date: Date.today, account_status: :active }
    expect(subject.withdraw(amount: 50, pin_code: '9999', account: account, account_status: :active)).to eq expected_output
  end

  it 'rejects withdraw if card is expired' do
    allow(account).to receive(:exp_date).and_return('12/15')
    expected_output = { status: false, message: 'card expired', date: Date.today, account_status: :active }
    expect(subject.withdraw(amount: 10, pin_code: '1234', account: account, account_status: :active)).to eq expected_output
  end

  it 'rejects withdraw if account is disabled' do
    expected_output = { status: false, message: 'account disabled', date: Date.today, account_status: :disabled }
    expect(subject.withdraw(amount: 50, pin_code: '1234', account: account, account_status: :disabled)).to eq expected_output
  end
end
