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
    puts "Daily transfers for the chosen company: #{@name} is now complete."
    puts "You can see the new-balance in: #{self.account_status_data_path}"
    puts "For transfer status check: #{self.transfer_status_data_path}"
  rescue StandardError => e
    puts "Sorry, an error occured while attempting to perform the daily transfer for #{@name}"
    puts "Error Details for admin: #{e.full_message}"
  end

end