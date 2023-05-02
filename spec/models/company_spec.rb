require 'spec_helper'
require './app/models/company'

RSpec.describe Company, type: :models do

  describe "Company.new" do
    it "Company cannot be created by calling `Company.new` raises errror" do
      expect{ Company.new }.to raise_error(NoMethodError)
    end
  end


  describe "Company.find" do
    subject { Company.find(company_name) }

    context "when company data does not exist" do
      let(:company_name) { "non-existinent-company" }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end

    context "when company data exists" do
      let(:company_name) { "alphasales" }

      it "returns company object" do
        expect(subject).to be_a Company
        expect(subject.name).to eq(company_name)
      end
    end
  end # describe '.find'


  describe "Company#accounts" do
    it_behaves_like "accounts loader" do
      let(:company_name) { "alphasales" }
      let(:company) { Company.find(company_name) }
      subject { company.accounts_data }
    end
  end


  describe "Company#transfers" do
    it_behaves_like "transfers loader" do
      let(:company_name) { "alphasales" }
      let(:company) { Company.find(company_name) }
      subject { company.transfers_data }
    end
  end

  describe "Company#perform_transfers" do
    let(:company_name) { "alphasales" }
    let(:company) { Company.find(company_name) }

    subject { company.perform_transfers }

    it "performs on transfer objects" do
      allow_any_instance_of(Transfer).to receive(:perform)
      expect(company.transfers_data.first).to receive(:perform).at_least(:once).and_call_original
      expect(company.transfers_data.last).to receive(:perform).at_least(:once).and_call_original
      subject
    end

    it "performs transfer on each of the transfers" do
      # not the best practice but confirms that perform was called for all the transfer records
      # most of the time the above should be enough
      processed_transfer_count = 0
      allow_any_instance_of(Transfer).to receive(:perform) { processed_transfer_count += 1 }
      subject
      expect(processed_transfer_count).to be 4
    end

    it "writes new accounts balance to account_status_data csv file" do
      subject
      new_filename = company.account_status_data_path
      data_to_array = CSV.read(new_filename)
      expected_records = [
        %w|account balance validity|,
        %w|1111234522226789 4820.5 valid|,
        %w|3212343433335755 48679.5 valid|,
      ]
      expect(data_to_array).to include(*expected_records)
    end

    it "writes new accounts balance to account_status_data csv file" do
      subject
      new_filename = company.transfer_status_data_path
      data_to_array = CSV.read(new_filename)
      expected_records = [
        ["from", "to", "amount", "status", "remarks"],
        ["1111234522226789", "1212343433335665", "500.0", "success", nil],
        ["1111234522221234", "1212343433335665", "25.6", "success", nil]
      ]
      expect(data_to_array).to include(*expected_records)
    end
  end # `#perform_transfers`

end