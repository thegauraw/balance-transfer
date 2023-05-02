require 'spec_helper'
require './app/models/collections/accounts'
require './app/models/company'

RSpec.describe Accounts, type: :collection do
  let(:company) { Company.find('alphasales') }
  let(:accounts) { Accounts.load_for(company) }

  describe "Accounts#load_for" do
    subject { accounts }

    it "creates accounts collection object" do
      expect(subject).to be_an Accounts
    end
  end # `#load_for`


  describe "Accounts#to_hashes" do

    subject { accounts.to_data_hashes }

    it "returns list of hashes containing account details" do
      expected_hash = {"account" => "1111234522226789", "balance" => 5000.0, "validity" => "valid"}

      expect(subject).to include(expected_hash)
    end
  end


  describe "Accounts#data" do
    subject { accounts.data }

    it "returns hash of accounts" do
      actual_hash = subject
      transformed_hash = actual_hash.transform_values!(&:to_data_hash)
      expected_hash = {
        "1111234522226789" => {
          "account" => "1111234522226789",
          "balance" => 5000.0,
          "validity" => "valid"
        }
      }

      expect(transformed_hash).to include(expected_hash)
    end
  end


  describe "Accounts#write_data" do
    subject { accounts.write_data }

    it "writes accounts data to account_status_data csv file" do
      subject
      data_to_array = CSV.read(company.account_status_data_path)
      expected_records = [
        %w|account balance validity|,
        %w|1111234522226789 5000.0 valid|,
        %w|3212343433335755 50000.0 valid|,
      ]

      expect(data_to_array).to include(*expected_records)
    end

  end

end