class AccountInvalidError < StandardError
  def initialize(msg="InvalidAccount")
    super
  end
end