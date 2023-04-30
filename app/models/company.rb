require_relative '../lib/data_utils'
require_relative '../services/accounts_loader'
require_relative '../services/transfers_loader'

class Company
  extend DataUtils

  attr_accessor :name, :account_data_path, :transfer_data_path

  def initialize(name, account_data_path, transfer_data_path)
    @name = name
    @account_data_path = account_data_path
    @transfer_data_path = transfer_data_path
    @accounts = nil
    @transfers = nil
  end

  private_class_method :new

  def self.find(name)
    account_data_path = get_account_data_path_for(name)
    transfer_data_path = get_transfer_data_path_for(name)
    if account_data_path
      new(name, account_data_path, transfer_data_path)
    end
  end

  def accounts
    @accounts ||= AccountsLoader.new(self).call
  end

  def transfers
    @transfers ||= TransfersLoader.new(self).call
  end

end