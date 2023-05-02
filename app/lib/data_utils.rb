module DataUtils
  DATA_FOLDER = 'data'

  def self.included(base)
    base.extend(ClassMethods)
  end

  def account_data_path
    get_data_path
  end

  def transfer_data_path
    get_data_path(data_category: 'trans')
  end

  def account_status_data_path
    account_data_path.gsub('.csv', '-updated.csv')
  end

  def transfer_status_data_path
    transfer_data_path.gsub('.csv', '-updated.csv')
  end

  module ClassMethods
    def is_account_data_available_for?(company_name)
      data_path = File.join(DATA_FOLDER, "#{company_name}_acc_balance.csv")
      File.exist?(data_path)
    end
  end

  private

  def get_data_path(data_category: 'acc_balance')
    data_path = File.join(DATA_FOLDER, "#{@name}_#{data_category}.csv")
    data_path if File.exist?(data_path)
  end

end