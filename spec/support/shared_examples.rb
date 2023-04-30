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