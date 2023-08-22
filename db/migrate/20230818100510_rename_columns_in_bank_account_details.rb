class RenameColumnsInBankAccountDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :bank_account_details, :iban, :IBAN
    rename_column :bank_account_details, :branch_name, :branch_code
  end
end
