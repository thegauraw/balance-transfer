require 'spec_helper'
# require_relative '../../app/services/accounts_loader'
require './app/models/company'
require './app/services/accounts_loader'

RSpec.describe AccountsLoader, type: :service do

  describe "AccountsLoader#call" do
    let(:company) { Company.find('alphasales') }

    subject { AccountsLoader.new(company).call }

    include_examples "accounts loader"

  end

end