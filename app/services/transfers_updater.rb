require 'csv'
require './app/lib/csv_utils'

class TransfersUpdater

  def initialize(company)
    @company = company
  end

  def call
    data_hashes = @company.transfers.map(&:to_data_hash)
    # data_hashes = @company.transfers.map(&:to_h)
    new_filename = @company.transfer_data_path.gsub('.csv', '-updated.csv')
    CsvUtils.write_hash_to_csv_file(data_hashes, new_filename)
  end

end