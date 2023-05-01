require 'csv'
require './app/lib/csv_utils'

class AccountsUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.accounts.values.map(&:to_data_hash)
    new_filename = @company.account_data_path.gsub('.csv', '-updated.csv')
    CsvUtils.write_hash_to_csv_file(data_hashes, new_filename)
  end

end