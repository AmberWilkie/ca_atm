require './lib/atm.rb'

describe Atm do
  let(:account) { double('Account') }

  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
  end

  it 'has $1k on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'reduces funds at withdrawal' do
    subject.withdraw(50, account)
    expect(subject.funds).to eq 950
  end

  it 'allows withdrawal if account has the funds available' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 45 }
    expect(subject.withdraw(45, account)).to eq expected_output
  end



end
