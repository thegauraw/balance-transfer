require 'spec_helper'
require './app/models/account'

RSpec.describe Account, type: :models do
  let(:row) { {"account" => "1111234522226789", "balance" => "5000.00" } }

  describe "Account.validate" do
    let(:account) { Account.new("1111234522226789", "5000.00") }

    subject { account.validate }

    context "an account with 16 digit" do
      it "must be valid" do
        subject
        expect(account.validity).to eq("valid")
      end
    end

    context "an account with id other than 16 digit" do
      context "with 15 digit id" do
        let(:account) { Account.new("123456789012345", "5000.00") }

        it "must NOT be valid" do
          subject
          expect(account.validity).to eq("invalid")
        end
      end

      context "with 16 characters id" do
        let(:account) { Account.new("abcdefghijklmnop", "5000.00") }

        it "must NOT be valid" do
          subject
          expect(account.validity).to eq("invalid")
        end
      end
    end
  end

  describe "Account.validate!" do
    let(:account) { Account.new("1111234522226789", "5000.00") }

    subject { account.validate! }

    context "when account is valid" do
      it "sets validity to 'valid'" do
        subject
        expect(account.validity).to eq("valid")
      end
    end

    context "when account is NOT valid" do
      let(:account) { Account.new("123456789012345", "5000.00") }
      it "raises 'AccountInvalidError'" do
        expect{ subject }.to raise_error(AccountInvalidError)
      end
    end
  end



end