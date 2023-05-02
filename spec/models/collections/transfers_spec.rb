require 'spec_helper'
require './app/models/collections/transfers'
require './app/models/company'

RSpec.describe Transfers, type: :collection do
  let(:company) { Company.find('alphasales') }
  let(:transfers) { Transfers.load_for(company) }


  describe "Transfers#load_for" do
    subject { transfers }

    it "creates transfers collection object" do
      expect(subject).to be_an Transfers
    end
  end # `#load_for`


  describe "Transfers#to_hashes" do
    subject { transfers.to_data_hashes }

    it "returns list of hashes containing account details" do
      expected_hash = {
        "from" => "1111234522226789",
        "to" => "1212343433335665",
        "amount" => 500.0,
        "status" => nil,
        "remarks" => nil
       }

      expect(subject).to include(expected_hash)
    end
  end


  describe "Transfers#data" do
    subject { transfers.data }

    it "returns hash of transfers" do
      actual_hash = subject
      transformed_hash = actual_hash.map(&:to_data_hash)
      expected_item = {
         "from" => "1111234522226789",
         "to" => "1212343433335665",
         "amount" => 500.0,
         "status" => nil,
         "remarks" => nil
        }

      expect(transformed_hash).to include(expected_item)
    end

  end


  describe "Transfers#write_data" do
    subject { transfers.write_data }

    it "writes transfers data to account_status_data csv file" do
      subject
      data_to_array = CSV.read(company.transfer_status_data_path)
      expected_records = [
        ["from", "to", "amount", "status", "remarks"],
        ["1111234522226789", "1212343433335665", "500.0", nil, nil],
        ["1111234522221234", "1212343433335665", "25.6", nil, nil]
      ]

      expect(data_to_array).to include(*expected_records)
    end

  end

end