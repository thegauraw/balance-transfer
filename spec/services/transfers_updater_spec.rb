require 'spec_helper'
require './app/models/company'
require './app/services/transfers_updater'

RSpec.describe TransfersUpdater, type: :service do

  describe "TransfersUpdater#call" do
    let(:company) { Company.find('alphasales') }

    subject { TransfersUpdater.new(company).call }

    before do
      company.transfers.each{|transfer| transfer.status="success" }
    end

    include_examples "update csv file with transfer-status"

  end

end