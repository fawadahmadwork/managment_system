class AddColumnToBankAccountDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_account_details, :iban, :string
  end
end
