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

  describe "Transfer#perform" do
    let(:transfer) { Transfer.create_from_csv(row, accounts) }
    subject { transfer.perform }

    context "when transfer is invalid i.e. from_account's balance is lower than transfer amount" do
      before do
        allow(transfer.from_account).to receive(:withdraw).and_raise(BalanceInsufficientError)
      end

      it "may attempt withdraw but does not deposit" do
        expect(transfer.from_account).to receive(:withdraw)
        expect(transfer.to_account).to_not receive(:deposit)
        subject
      end

      it "NO change in from_account balance" do
        expect{ subject }.to_not change{ transfer.from_account.balance }
      end

      it "NO change in to_account balance" do
        expect{ subject }.to_not change{ transfer.to_account.balance }
      end

      it "sets status 'error'" do
        subject
        expect(transfer.status).to eq("error")
      end
    end

    context "when transfer is valid  i.e. from_account's balance is higher than transfer amount" do
      before do
        allow(transfer.from_account).to receive(:withdraw)
        allow(transfer.to_account).to receive(:deposit)
      end

      it "withdraws and deposits" do
        expect(transfer.from_account).to receive(:withdraw).and_call_original
        expect(transfer.to_account).to receive(:deposit).and_call_original
        subject
      end

      it "sets status 'success'" do
        subject
        expect(transfer.status).to eq("success")
      end

    end

  end
end