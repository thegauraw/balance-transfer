require 'spec_helper'
require './app/models/company'
require './app/services/transfers_loader'

RSpec.describe TransfersLoader, type: :service do

  describe "TransfersLoader#call" do
    let(:company) { Company.find('alphasales') }

    subject { TransfersLoader.new(company).call }

    include_examples "transfers loader"

  end

end