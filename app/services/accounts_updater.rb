require 'csv'
require './app/lib/csv_utils'

class AccountsUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.accounts.values.map(&:to_data_hash)
    account_status_update_filepath = @company.account_status_data_path
    CsvUtils.write_hash_to_csv_file(data_hashes, account_status_update_filepath)
  end

end