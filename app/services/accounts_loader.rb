require 'csv'
require './app/models/account'

class AccountsLoader
  DATA_FOLDER = 'data'

  def initialize(company)
    @company = company
  end

  def call
    accounts = {}

    convert_to_lowercase = lambda { |header| header.downcase }
    CSV.foreach(@company.account_data_path, headers: true, header_converters: convert_to_lowercase) do |row|
      account = Account.create_from_csv(row)
      accounts[account.id] = account
    end

    accounts
  end

end