require 'csv'
require './app/lib/csv_utils'

class TransfersUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.transfers.map(&:to_data_hash)
    CsvUtils.write_hash_to_csv_file(data_hashes, @company.transfer_status_data_path)
  end

end