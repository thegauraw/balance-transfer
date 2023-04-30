shared_examples "account loader" do

  it "loads all the account balance in the CSV data-file" do
    expect(subject.length).to eq(5)
  end

  it "loads relevant account details for the company" do
    actual_results = subject
    actual_results.transform_values!(&:to_h)
    expected_result = {
      "1111234522226789" => Account.new("1111234522226789", "5000.00").to_h,
      "1111234522221234" => Account.new("1111234522221234", "10000.00").to_h,
      "2222123433331212" => Account.new("2222123433331212", "550.00").to_h,
      "1212343433335665" => Account.new("1212343433335665", "1200.00").to_h,
      "3212343433335755" => Account.new("3212343433335755", "50000.00").to_h
    }
    expect(actual_results).to include(expected_result)
  end

end