require './exceptions/account_invalid_error'

module AccountValidator

  def validate
    validate!
  rescue AccountInvalidError => e
    puts "Error! #{e.message} - account: #{@id} "
    @validity = "invalid"
  end

  def validate!
    raise AccountInvalidError unless /^\d{16}$/.match?(@id)
    @validity = "valid"
  end
end