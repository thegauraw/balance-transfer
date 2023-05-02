require 'spec_helper'
require './app/models/company'
require './app/services/accounts_updater'

RSpec.describe AccountsUpdater, type: :service do

  describe "AccountsUpdater#call" do
    let(:company) { Company.find('alphasales') }

    subject { AccountsUpdater.new(company).call }

    before do
      account_data = {
        "1111234522226789" => Account.new("1111234522226789", "4820.5"),
        "3212343433335755" => Account.new("3212343433335755", "48679.5")
      }
      allow(company).to receive(:accounts).and_return(account_data)
    end

    include_examples "update csv file with new account balance"

  end

end