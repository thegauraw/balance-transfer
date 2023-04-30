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

    it_behaves_like "account loader" do
      let(:company_name) { "alphasales" }
      let(:company) { Company.find(company_name) }
      subject { company.accounts }
    end

  end

end