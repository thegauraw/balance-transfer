require_relative '../services/accounts_loader'

class Company
  DATA_FOLDER = "data"

  attr_accessor :name, :account_data_path

  def initialize(name, account_data_path)
    @name = name
    @account_data_path = account_data_path
    @accounts = nil
  end

  private_class_method :new

  def self.find(name)
    data_path = data_fullpath(name)
    if data_path
      new(name, data_path)
    end
  end

  def self.data_fullpath(name)
    datapath = File.join(DATA_FOLDER, "#{name}_acc_balance.csv")
    datapath if File.exist?(datapath)
  end

  def accounts
    @accounts ||= AccountsLoader.new(self).call
  end

end