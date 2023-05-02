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

    # TODO: Check for account validity before tranfer
    # def Account#is_valid?
    #   @validity == "valid"
    # end
    # if from_account.is_valid? && to_account.is_valid?
    # create transfer with @status="error" @remarks="InvalidAccount" if any account is invalid

    new(from_account, to_account, amount)
  end

  def to_h
    {"from" => @from_account.id, "to" => @to_account.id, "amount" => @amount}
  end

  def to_data_hash
    {"from" => @from_account.id, "to" => @to_account.id, "amount" => @amount, "status" => @status, "remarks" => @remarks}
  end

  def perform
    # TODO: Check for account validity before tranfer
    # only perform on transfers without @status == "error"
    @from_account.withdraw(amount)
    @to_account.deposit(amount)
    @status = "success"
  rescue BalanceInsufficientError => e
    puts "Error! #{e.message} - from: #{@from_account.to_h} amount: #{@amount} "
    @status = "error"
    @remarks = e.message
  end
end

