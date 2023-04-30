class Transfer
  attr_accessor :from_account, :to_account, :amount

  def initialize(from_account, to_account, amount)
    @from_account = from_account
    @to_account = to_account
    @amount = amount.to_f
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

  def is_valid?
    @amount < @from_account.balance
  end

  def perform
    if is_valid?
      @from_account.balance -= @amount
      @to_account.balance += @amount
    end
  end
end