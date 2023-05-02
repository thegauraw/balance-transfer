require_relative '../../services/accounts_loader'
require_relative '../../lib/csv_utils'

class Accounts
  def initialize(company)
    @company = company
    @accounts = AccountsLoader.new(company).call
  end

  private_class_method :new

  def self.load_for(company)
    new(company)
  end

  def write_data#(data_path)
    CsvUtils.write_hash_to_csv_file(self.to_data_hashes, @company.account_status_data_path)#,data_path)
  end

  def data
    @accounts
  end

  def to_data_hashes
    @accounts.values.map(&:to_data_hash)
  end
end