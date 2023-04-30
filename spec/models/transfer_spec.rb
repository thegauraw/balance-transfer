require 'spec_helper'
require './app/models/transfer'

RSpec.describe Transfer, type: :models do
  let(:row) { { "from" => "1111234522226789", "to" => "1212343433335665", "amount" => "500.00" } }

  describe "Transfer#create_from_csv" do
    subject { Transfer.create_from_csv(row) }

    it "creates transfer object" do
      expect(subject).to be_an Transfer
    end

    it "creates appropriate transfer records" do
      expect(subject.from_account).to eq("1111234522226789")
      expect(subject.to_account).to eq("1212343433335665")
      expect(subject.amount).to eq(500.00)
    end
  end # `#create_from_csv`

  describe "Transfer#to_h" do
    let(:transfer) { Transfer.create_from_csv(row) }

    subject { transfer.to_h }

    it "responds to to_h with transfer details" do
      expected_result = row
      expected_result["amount"] = expected_result["amount"].to_f
      expect(subject).to include(row)
    end
  end


end