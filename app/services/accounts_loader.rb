require 'csv'

class AccountsLoader
  DATA_FOLDER = 'data'

  def initialize(company_name)
    @company_name = company_name
    @accounts = []
  end

  def call
    data_path = data_fullpath

    if data_path
      CSV.foreach(data_path, headers: true) do |row|
        @accounts << row.to_s.strip
      end
    end

    @accounts
  end

  private

  def data_fullpath
    datapath = File.join(DATA_FOLDER, "#{@company_name}_acc_balance.csv")
    datapath if File.exist?(datapath)
  end

end