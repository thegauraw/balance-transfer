require './exceptions/balance_insufficient_error'

class Transfer
  attr_accessor :from_account, :to_account, :amount, :status, :remarks

  def initialize(from_account, to_account, amount)
    @from_account = from_account
    @to_account = to_account
    @amount = amount.to_f
    @status = nil
    @remarks = nil
  end

  def self.create_from_csv(row, accounts)
    from_account = accounts[row["from"]]
    to_account = accounts[row["to"]]
    amount = row["amount"]
    new(from_account, to_account, amount)
  end

  def to_h
    {"from" => @from_account.id, "to" => @to_account.id, "amount" => @amount}
  end

  def perform
    @from_account.withdraw(amount)
    @to_account.deposit(amount)
    @status = "success"
  rescue BalanceInsufficientError => e
    puts "Error! #{e.message} - from: #{@from_account.to_h} amount: #{@amount} "
    @status = "error"
    @remarks = e.message
  end
end

