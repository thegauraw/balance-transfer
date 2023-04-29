class Company
  DATA_FOLDER = "data"

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.find(name)
    data_path = data_fullpath(name)
    if data_path
      new(name)
    end
  end

  def self.data_fullpath(name)
    datapath = File.join(DATA_FOLDER, "#{name}_acc_balance.csv")
    datapath if File.exist?(datapath)
  end

end