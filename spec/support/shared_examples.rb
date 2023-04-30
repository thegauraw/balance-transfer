shared_examples "account loader" do

  it "loads all the account balance in the CSV data-file" do
    expect(subject.length).to eq(5)
  end

  it "loads relevant account details for the company" do
    expected_output = %w[
      1111234522226789,5000.00
      1111234522221234,10000.00
      2222123433331212,550.00
      1212343433335665,1200.00
      3212343433335755,50000.00
    ]
    expect(subject).to eq(expected_output)
  end

end