require 'spec_helper'
require './app/models/account'
require './app/models/transfer'

RSpec.describe Transfer, type: :models do
  let(:row) { { "from" => "1111234522226789", "to" => "1212343433335665", "amount" => "500.00" } }
  let(:accounts) {
    {
      "1111234522226789" => Account.new("1111234522226789", "5000.00"),
      "1212343433335665" => Account.new("1212343433335665", "1200.00")
    }
  }

  describe "Transfer#create_from_csv" do
    subject { Transfer.create_from_csv(row, accounts) }

    it "creates transfer object" do
      expect(subject).to be_an Transfer
    end

    it "creates appropriate transfer records" do
      transfer = subject
      expect(transfer.from_account.id).to eq("1111234522226789")
      expect(transfer.to_account.id).to eq("1212343433335665")
      expect(transfer.amount).to eq(500.00)
    end
  end # `#create_from_csv`

  describe "Transfer#to_h" do
    let(:transfer) { Transfer.create_from_csv(row, accounts) }

    subject { transfer.to_h }

    it "responds to to_h with transfer details" do
      expected_result = row
      expected_result["amount"] = expected_result["amount"].to_f
      expect(subject).to include(row)
    end
  end

  describe "Transfer#is_valid?" do
    let(:transfer) { Transfer.create_from_csv(row, accounts) }
    subject { transfer.is_valid? }

    context "when amount to transfer is more than from_account's balance" do
      before do
        transfer.amount = 6000
      end

      it "returns false" do
        expect(subject).to be false
      end
    end

    context "when amount to transfer is less than from_account's balance" do
      it "returns true" do
        expect(subject).to be true
      end
    end
  end

  describe "Transfer#perform" do
    let(:transfer) { Transfer.create_from_csv(row, accounts) }
    subject { transfer.perform }

    context "when transfer is invalid" do
      it "returns nil" do
        allow(transfer).to receive(:is_valid?).and_return(false)
        expect(subject).to be_nil
      end
    end

    context "when transfer is valid" do
      it "reduces the balance of from_account by transfer amount" do
        allow(transfer).to receive(:is_valid?).and_return(true)
        expect{ subject }.to change{ transfer.from_account.balance }.from(5000.0).to(4500.0)
      end

      it "increments the balance of to_account by transfer amount" do
        allow(transfer).to receive(:is_valid?).and_return(true)
        expect{ subject }.to change{ transfer.to_account.balance }.from(1200.0).to(1700.0)
      end
    end

  end
end