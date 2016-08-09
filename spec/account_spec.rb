require './lib/account.rb'

describe Account do
  let(:person) {double('Person')}
  subject { described_class.new(person) }

  before do
    allow(person).to receive(:name).and_return('Jeff Miles')
    allow(person).to receive(:cash).and_return(0)
  end

  it 'validates the account has an person' do
    expect(subject.person.name).to eq 'Jeff Miles'
  end

  it 'validates PIN code has the right number of digits' do
    number = subject.pin_code
    number_length = Math.log10(number).to_i + 1
    expect(number_length).to eq 4
  end

  it 'checks to see if account is active' do
    expect(subject.account_status).to eq :active
  end

  it 'account status can be set to disabled' do
    subject.deactivate
    expect(subject.account_status).to eq :disabled
  end

  it 'cannot change pin' do
    expect{subject.pin_code=1234}.to raise_error(NoMethodError)
  end

  it 'has a balance of 100 on initialize' do
    expect(subject.balance).to eq 100
  end

  it 'has an expiration date that is before today' do
    expect(subject.exp_date).to be > Date.today.strftime('%m/%y')
  end

  it 'is expected to have an expiration date on initialize' do
    expected_date = Date.today.next_year(5).strftime('%m/%y')
    expect(subject.exp_date).to eq expected_date
  end


end
