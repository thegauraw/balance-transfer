require './app/models/company'

def run_transfer(company_name)
  company = Company.find(company_name)

  return "Sorry, No account information found for #{company_name}" if company.nil?

  company.perform_transfers
  "----------------------------------------------------------------"
end

if __FILE__ == $0
  puts "==============================================================="
  puts "==============================================================="
  puts "Welcome to Simple Banking Service"
  puts "We transfer balance between accounts for a company"
  puts "Pick a company you want to run transfer for (default='mable'):"

  company_name = gets.chomp
  company_name = "mable" if company_name.length.zero?

  puts run_transfer(company_name)
  puts "----------------------------------------------------------------"
  puts "Thank you! :)"
end
