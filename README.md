# balance-transfer
Simple ruby app that loads accounts of customers for a company and transfers balance between those accounts.

-------------------

## How to run?
### Bank Transfer Operation:
* Step 0: Have ruby `3.2.2` installed (e.g. with rvm: `rvm install 3.2.2`)
* Step 1: Run `ruby run.rb`
* Step 2: follow the instructions: Enter company name
* Step 3: Receive transfer operation feedback
* Step 4: Check out the transfer results & status in:
  * `data/<company_name>_acc_balance-updated.csv` &
  * `data/<company_name>_trans-updated.csv`

### Test specs:
* Step 1: `bundle install`
* Step 2: `bundle exec rspec`
* Step 3: Checkout the documentation output
* Step 4: Open `coverage/index.html` for code coverage report in browser

-------------------

## Challenge:
You are a developer for a company that runs a very simple banking service.
Each day companies provide you with a CSV file with transfers they want to make between accounts for customers they are doing business with.
Accounts are identified by a 16 digit number and money cannot be transferred from them if it will put the account balance below $0.

Your job is to implement a simple system that can:
* load account balances for a single company and then
* accept a day's transfers in a CSV file.

An example customer balance file is provided as well as an example days transfers.

```csv
account,balance
1111234522226789,5000.00
1111234522221234,10000.00
2222123433331212,550.00
1212343433335665,1200.00
3212343433335755,50000.00
```

```csv
from,to,amount
1111234522226789,1212343433335665,500.00
3212343433335755,2222123433331212,1000.00
3212343433335755,1111234522226789,320.50
1111234522221234,1212343433335665,25.60
```

### Rubrick:
* Data Structure
  * uses domain models
  * uses native data structures readably
* uses rspec for test
  * has good coverage
  * tests are orthogonal
  * tests explain the functionality
* Object Orientation
  * models encapsulate logic appropriately
  * respects separation of concerns
  * short methods
  * readable methods
* General
  * runs and provides feedback
  * calculates test files accurately




--------------------
### My Notes:
* Background: Company runs a very simple banking service.
* There are many companies -> each companies have customers
* Input files:
  * Companies have CSV with daily account balance: `acc_balance.csv`
  * Companies provide CSV file with daily transfer amount: `trans.csv`
* Daily Operation:
  * load the balance
  * perform transfer
* Output files:
  * 2 separate output files:
    * `acc_balance-updated.csv`
    * `trans-updated.csv`
* Validations:
  * Account must be 16 digit number
  * Transfer allowed only if balance >= 0


### Assumptions:
* CSV data files are named in the format: `<company_name>_acc_balance.csv` & `<company_name>_trans.csv` and placed inside a given folder `data`
* If any of the record is invalid, perform transfer for the valid records (update status as success), & abort the transfer for the invalid record (update status as error)
* Keeping the input files intact: create another output files to record transfer status & new balance


------

### Few questions
* (Validation specifics) How to handle validation errors?
  * My Suggestions:
    * For invalid data in account file:
      * if account number is invalid
        - discard the record while loading the balance
        - update record's validity
    * For invalid data in transaction file:
      * if from account number does not exist:
        - do not perform any transaction
        - update transfer status
      * (Edge cases) New transfer to non-existing Account Number:
        - do not perform any transaction
        - update transfer status
      * If transfer puts the account balance below $0:
        - do not perform any transaction
        - update transfer status


--------------------

#### Problem solving approach (based on PR):

* Load balance for all the accounts for a company
  * Setup RSpec test framework
  * Setup Guard for TDD
  * Add models: Company & Account
  * Add services: AccountLoader
  * Finds the company records and loads relevant account-balance records for the company
* Load all the tranfers data for the company
  * Add models: Transfer
  * Add services: TransfersLoader
  * Load all the transfers for the company and associate with the relevant accounts in the company
* Transfer balances between accounts
  * Add lib: CsvUtils
  * Execute the transfer between the accounts
  * Add services: AccountsUpdater
* Refactoring account and transfer
  * Separation of concerns between accounts and transfer
  * Account and Transfer now have single responsibility
  * Validation of Account and transfers
  * Add Error handling
* Refactor Record Updater:
  * Use service object to update/save accounts and transfer status records
* Refactoring and final touch:
  * Refactoring: Simplify access of company data path
  * Refactoring: Introducing new data collection class to organize accounts and * transfers data and operations
  * Cleaner transfer action and updating the records
  * Setup script run.rb to run the daily transfer operation (ruby run.rb)
  * Add simplecov gem for test code coverage analysis

#### TODO: Future improvements & other approaches
* Lock the files while loading particular company record & during the operation
  * lock the file when loading the account (before CSV read)
  * Unlock the file once the transfer is complete (after CSV write)
* Update the input file,
  * update the row with transfer status (success/fail) and datetime of transfer
  * allow to retry
    * because as the fund transfer is sequential, the account with insufficient fund may have enough for the transfer towards the end of the operation
    * sometimes after fixing some data
  * Make transfer operation idempotent (with statuses) to guard
