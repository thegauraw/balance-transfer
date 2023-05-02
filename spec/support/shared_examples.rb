shared_examples "accounts loader" do

  it "loads all the account balance in the CSV data-file" do
    expect(subject.length).to eq(5)
  end

  it "loads relevant account details for the company" do
    accounts = subject
    accounts.transform_values!(&:to_h)
    expected_result = {
      "1111234522226789" => Account.new("1111234522226789", "5000.00").to_h,
      # "1111234522221234" => Account.new("1111234522221234", "10000.00").to_h,
      # "2222123433331212" => Account.new("2222123433331212", "550.00").to_h,
      # "1212343433335665" => Account.new("1212343433335665", "1200.00").to_h,
      "3212343433335755" => Account.new("3212343433335755", "50000.00").to_h
    }
    expect(accounts).to include(expected_result)
  end

end


shared_examples "transfers loader" do

  it "loads all the balance transfers in the CSV data-file" do
    expect(subject.length).to eq(4)
  end

  it "loads relevant balance transfer details for the company" do
    transfers = subject
    transfers.map!(&:to_h)
    expected_result = [
      {"from" => "1111234522226789", "to" => "1212343433335665", "amount" => 500.0},
      {"from" => "1111234522221234", "to" => "1212343433335665", "amount" => 25.6}
    ]

    expect(transfers).to include(*expected_result)
  end

end

shared_examples "update csv file with new account balance" do
  it "writes new account balances to csv" do
    subject
    new_filename = company.account_data_path.gsub('.csv', '-updated.csv')
    data_to_array = CSV.read(new_filename)
    expected_records = [
      %w|account balance validity|,
      %w|1111234522226789 4820.5 valid|,
      %w|3212343433335755 48679.5 valid|,
    ]
    expect(data_to_array).to include(*expected_records)
  end
end

shared_examples "update csv file with transfer-status" do
  it "writes new transfers status to csv" do
    subject
    new_filename = company.transfer_data_path.gsub('.csv', '-updated.csv')
    data_to_array = CSV.read(new_filename)
    expected_records = [
      ["from", "to", "amount", "status", "remarks"],
      ["1111234522226789", "1212343433335665", "500.0", "success", nil],
      ["1111234522221234", "1212343433335665", "25.6", "success", nil]
    ]
    expect(data_to_array).to include(*expected_records)
  end
end