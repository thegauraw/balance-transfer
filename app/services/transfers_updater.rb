require 'csv'
require './app/lib/csv_utils'

class TransfersUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.transfers.map(&:to_data_hash)
    # data_hashes = @company.transfers.map(&:to_h)
    transfer_status_update_filepath = @company.transfer_status_data_path
    CsvUtils.write_hash_to_csv_file(data_hashes, transfer_status_update_filepath)
  end

end