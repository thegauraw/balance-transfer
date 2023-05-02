require './exceptions/balance_insufficient_error'
require_relative './validators/account_validator'

class Account
  include AccountValidator
  attr_accessor :id, :balance, :validity

  def initialize(account, balance)
    @id = account
    @balance = balance.to_f
    validate
  end

  def self.create_from_csv(row)
    new(row['account'], row['balance'])
  end

  def to_h
    {"account" => @id, "balance" => @balance}
  end

  def to_data_hash
    {"account" => @id, "balance" => @balance, "validity" => @validity}
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