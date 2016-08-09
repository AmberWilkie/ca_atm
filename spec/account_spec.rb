require './lib/account.rb'

describe Account do
  let(:owner) {double('Owner')}
  subject { Account.new()}

  before do
    allow(owner).to receive(:name).and_return('Jeff Miles')
    allow(owner).to receive(:cash).and_return(0)
  end

  it 'validates the account has an owner' do
    subject.owner = owner
    expect(subject.owner.name).to eq 'Jeff Miles'
  end

  it 'validates PIN code is correct' do
    expect(subject.pin_code).to eq 5555
  end

  it 'checks to see if account is active' do
    expect(subject.account_status).to eq 'active'
  end

  it 'account status can be set to disabled' do
    subject.account_status = 'disabled'
    expect(subject.account_status).to eq 'disabled'
  end

  it 'cannot change pin' do
    expect{subject.pin_code=1234}.to raise_error(NoMethodError)
  end

  it 'has a balance' do
    expect(subject.balance).to eq 100
  end

  it 'has an expiration date that is before today' do
    expect(subject.exp_date).to eq "01/20"
  end


end