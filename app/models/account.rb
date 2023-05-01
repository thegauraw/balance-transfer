require './exceptions/balance_insufficient_error'

class Account
  attr_accessor :id, :balance

  def initialize(account, balance)
    @id = account
    @balance = balance.to_f
  end

  def self.create_from_csv(row)
    new(row['account'], row['balance'])
  end

  def to_h
    {"account" => @id, "balance" => @balance}
  end

  def withdraw(amount)
    raise BalanceInsufficientError unless can_withdraw?(amount)
    @balance -= amount
  end

  def deposit(amount)
    @balance += amount
  end

  private

  def can_withdraw?(amount)
    @balance >= amount
  end
end