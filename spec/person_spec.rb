require './lib/person'
require './lib/atm'

describe Person do

  subject { described_class.new(name: 'Thomas') }

  it 'is expected to have a :name on initialize' do
    expect(subject.name).not_to be nil
  end

  it 'is expected to raise error if no name is set' do
    expect { described_class.new }.to raise_error 'A name is required'
  end

  it 'is expected to have a :cash attribute on initialize' do
    expect(subject.cash).not_to be nil #made this have 100 so oher tests will pass
  end

  it 'is expected to have an :account attribute' do
    expect(subject.account).to be nil
  end

  describe 'can create an Account' do
    # As a Person,
    # in order to be able to use banking services to manage my funds,
    # i would like to be able to create a bank account
    before { subject.create_account }

    it 'of Account class ' do
      expect(subject.account).to be_an_instance_of Account
    end

    it 'with himself as an owner' do
      expect(subject.account.owner).to be subject # I don't really get this one - isn't subject the instance...? I'm confused.
    end
  end

  describe 'can not manage funds if no account been created' do
    # As a Person without a Bank Account,
    # in order to prevent me from using the wrong bank account,
    # I should NOT be able to to make a deposit.
    it 'can\'t deposit funds' do
      expect { subject.deposit(0) }.to raise_error(RuntimeError, 'No account present')
    end
  end


  describe 'can manage funds if an account been created' do

    subject { described_class.new(name: 'Amber', cash: 100) }

    let(:atm) { Atm.new }
    # As a Person with a Bank Account,
    # in order to be able to put my funds in the account ,
    # i would like to be able to make a deposit
    before { subject.create_account }

    it 'can deposit funds' do
      expect(subject.deposit(50)).to be_truthy
    end

    it 'deducts from cash if funds are added to account balance' do
      subject.deposit(100)
      expect(subject.account.balance).to be 100
      expect(subject.cash).to be 0
    end

    it 'can withdraw funds' do
      subject.deposit(100)
      command = lambda { subject.withdraw_from_atm(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm) }
      expect(command.call).to be_truthy
    end

    it 'expects withdraw to return error if no ATM is passed in' do
      command = lambda {subject.withdraw_from_atm(amount: 100, pin: subject.account.pin_code, account: subject.account)}
      expect{command.call}.to raise_error RuntimeError, 'An ATM is required'
    end

    it 'adds funds to @cash, deducts from @account.balance' do
      # binding.pry
      subject.withdraw_from_atm(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm)
      expect(subject.account.balance).to be 0
      expect(subject.cash).to be 100
    end

    it "references ATM's own withdraw method" do

    end


  end
end
