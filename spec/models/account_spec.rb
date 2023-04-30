require 'spec_helper'
require './app/models/account'

RSpec.describe Account, type: :models do
  let(:row) { {"account" => "1111234522226789", "balance" => "5000.00" } }

  describe "Account#create_from_csv" do
    subject { Account.create_from_csv(row) }

    it "creates account object" do
      expect(subject).to be_an Account
    end

    it "creates appropriate account records" do
      expect(subject.id).to eq("1111234522226789")
    #   expect(subject.balance).to eq(5000.00)
    end
  end # `#create_from_csv`

  describe "Account#to_h" do
    let(:account) { Account.create_from_csv(row) }

    subject { account.to_h }

    it "responds to to_h with account details" do
      expected_hash = {"id" => "1111234522226789", "balance" => 5000.0}
      expect(subject).to include(expected_hash)
    end
  end


end