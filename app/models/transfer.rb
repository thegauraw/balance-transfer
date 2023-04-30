class Transfer
  attr_accessor :from_account, :to_account, :amount

  def initialize(from_account, to_account, amount)
    @from_account = from_account
    @to_account = to_account
    @amount = amount.to_f
  end

  def self.create_from_csv(row)
    new(row['from'], row["to"], row['amount'])
  end

  def to_h
    {"from" => @from_account, "to" => @to_account, "amount" => @amount}
  end
end