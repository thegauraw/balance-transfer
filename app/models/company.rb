require_relative '../lib/data_utils'
require_relative '../services/accounts_loader'
require_relative '../services/accounts_updater'
require_relative '../services/transfers_loader'
require_relative '../services/transfers_updater'

class Company
  include DataUtils

  attr_accessor :name

  def initialize(name)
    @name = name
    @accounts = nil
    @transfers = nil
  end

  private_class_method :new

  def self.find(name)
    if is_account_data_available_for?(name)
      new(name)
    end
  end

  def account_status_data_path
    self.class.get_updated_account_path_for(name)
  end

  def transfer_status_data_path
    self.class.get_updated_transfer_path_for(name)
  end

  def accounts
    @accounts ||= AccountsLoader.new(self).call
  end

  def transfers
    @transfers ||= TransfersLoader.new(self).call
  end

  def perform_transfers
    transfers.each do |transfer|
      transfer.perform
    end
    # update the record
    AccountsUpdater.new(self).call
    TransfersUpdater.new(self).call
  end

end