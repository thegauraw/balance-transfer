require_relative '../lib/data_utils'
require_relative './collections/accounts'
require_relative './collections/transfers'

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

  def accounts
    @accounts ||= Accounts.load_for(self)
  end

  def transfers
    @transfers ||= Transfers.load_for(self)
  end

  def accounts_data
    accounts.data
  end

  def transfers_data
    transfers.data
  end

  def perform_transfers
    transfers.perform_all

    @accounts.write_data#_to(data_path)
    @transfers.write_data#_to(data_path)
  end

end