require 'csv'
require './app/models/transfer'

class TransfersLoader
  DATA_FOLDER = 'data'

  def initialize(company)
    @company = company
  end

  def call
    transfers = []

    convert_to_lowercase = lambda { |header| header.downcase }
    CSV.foreach(@company.transfer_data_path, headers: true, header_converters: convert_to_lowercase) do |row|
      transfer = Transfer.create_from_csv(row, @company.accounts_data)
      transfers << transfer
    end

    transfers
  end

end