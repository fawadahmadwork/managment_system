class AddEmailSentToSalarySlips < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_slips, :email_sent, :boolean
  end
end
