require 'csv'

class BalanceLoader
  DATA_FOLDER = 'data'

  def initialize(company_name)
    @company_name = company_name
    @accounts = []
  end

  def call
    data_fullpath = File.join(DATA_FOLDER, "#{@company_name}_acc_balance.csv")

    CSV.foreach(data_fullpath, headers: true) do |row|
      @accounts << row.to_s.strip
    end
    @accounts

  end

end