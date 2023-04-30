class Account
  attr_accessor :id #, :balance

  def initialize(account, balance)
    @id = account
    @balance = balance.to_f
  end

  def self.create_from_csv(row)
    new(row['account'], row['balance'])
  end

  def to_h
    {"id" => @id, "balance" => @balance}
  end
end