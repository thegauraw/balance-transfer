require 'csv'
require './app/lib/csv_utils'

class AccountsUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.accounts.values.map(&:to_data_hash)
    CsvUtils.write_hash_to_csv_file(data_hashes, @company.account_status_data_path)
  end

end