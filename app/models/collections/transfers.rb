require_relative '../../services/transfers_loader'
require_relative '../../lib/csv_utils'

class Transfers
  def initialize(company)
    @company = company
    @transfers = TransfersLoader.new(company).call
  end

  private_class_method :new

  def self.load_for(company)
    new(company)
  end

  def write_data#(data_path)
    CsvUtils.write_hash_to_csv_file(self.to_data_hashes, @company.transfer_status_data_path)#,data_path)
  end

  def perform_all
    @transfers.each do |transfer|
      transfer.perform
    end
  end

  def data
    @transfers
  end

  def to_data_hashes
    @transfers.map(&:to_data_hash)
  end
end