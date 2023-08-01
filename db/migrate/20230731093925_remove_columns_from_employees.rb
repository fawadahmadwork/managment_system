class RemoveColumnsFromEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :bank_account_details
    remove_column :employees, :email
    remove_column :employees, :phone_number
    remove_column :employees, :hire_date
    remove_column :employees, :emergency_contact
    remove_column :employees, :salary
  end
end
