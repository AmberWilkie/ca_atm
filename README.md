##ATM Challenge
###Week 1 Ruby challenge

Purpose
-------
This small application allows a "person" to open an "account" and deposit and withdraw funds at an "atm".


Instructions
-------

* Create a new person object with a name and (optionally) initial ``@cash``:
``amber = Person.new(name: "Amber", cash: 100)``
* Open an account for the person and put it in an instance variable: ``account = amber.create_account``
* Create an initial deposit to fund the account: ``amber.deposit(100)``
  * ``account.balance`` is now 100 and ``amber.cash`` is now 0
* Find out the account's ``@pin_code``: ``account.pin_code``
* Create an atm from which to withdraw funds: ``atm = Atm.new``
* Withdraw from the account: ``amber.withdraw_from_atm(atm: atm, amount: 50, account: account, pin: 2986)``
  * It will return a "receipt" with information in a hash: ``{:status=>true, :message=>"success", :date=>#<Date: 2016-08-13 ((2457614j,0s,0n),+0s,2299161j)>, :account_status=>:active, :amount=>50, :bills=>[20, 20, 10]}``
  * Account balance is now 50
  * ATM funds are now 950

Created for and with significant code snippets from [Craft Academy!] (http://www.craftacademy.se)
