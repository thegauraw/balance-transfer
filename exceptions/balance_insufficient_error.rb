class BalanceInsufficientError < StandardError
  def initialize(msg="InsufficientBalance")
    super
  end
end