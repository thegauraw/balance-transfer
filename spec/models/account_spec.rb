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

    it "validates when created" do
      expect(subject.validity).to eq("valid")
    end
  end # `#create_from_csv`

  describe "Account#to_h" do
    let(:account) { Account.create_from_csv(row) }

    subject { account.to_h }

    it "responds to to_h with account details" do
      expected_hash = {"account" => "1111234522226789", "balance" => 5000.0}
      expect(subject).to include(expected_hash)
    end
  end

  describe "Account#withdraw" do
    let(:account) { Account.create_from_csv(row) }

    subject { account.withdraw(amount) }

    context "when account-balance is higher than withdraw-amount" do
      let(:amount) { 500 }

      it "reduces the balance of from_account by transfer amount" do
        expect{ subject }.to change{ account.balance }.from(5000.0).to(4500.0)
      end
    end

    context "when account-balance is lower than withdraw-amount" do
      let(:amount) { 6000 }
      it "raises an exception" do
        expect{subject}.to raise_error(BalanceInsufficientError)
      end
    end
  end

  describe "Account.deposit" do
    let(:account) { Account.create_from_csv(row) }

    subject { account.deposit(500) }

    it "increments the balance of to_account by transfer amount" do
      expect{ subject }.to change{ account.balance }.from(5000.0).to(5500.0)
    end
  end

end