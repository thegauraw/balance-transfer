module DataUtils
  DATA_FOLDER = 'data'

  def get_account_data_path_for(company_name)
    get_data_path_for(company_name)
  end

  def get_transfer_data_path_for(company_name)
    get_data_path_for(company_name, data_category: 'trans')
  end

  private
  def get_data_path_for(company_name, data_category: 'acc_balance')
    data_path = File.join(DATA_FOLDER, "#{company_name}_#{data_category}.csv")
    data_path if File.exist?(data_path)
  end

end