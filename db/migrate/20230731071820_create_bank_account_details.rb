class CreateBankAccountDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_account_details do |t|
      t.string :account_title
      t.string :account_number
      t.string :bank_name
      t.string :branch_name
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
