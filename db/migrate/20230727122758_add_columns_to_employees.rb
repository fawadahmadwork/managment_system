class AddColumnsToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :date_of_birth, :date
    add_column :employees, :email, :string
    add_column :employees, :phone_number, :string
    add_column :employees, :address, :string
    add_column :employees, :national_id_card, :string
    add_column :employees, :designation, :string
    add_column :employees, :department, :string
    add_column :employees, :hire_date, :date
    add_column :employees, :termination_date, :date
    add_column :employees, :salary, :decimal, precision: 10
    add_column :employees, :emergency_contact, :string
    add_column :employees, :avatar, :string
    add_column :employees, :notes, :text
    add_column :employees, :employment_status, :string
    add_column :employees, :bank_account_details, :string

    
  end
end
