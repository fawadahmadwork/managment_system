class RenameDateColumnInSalarySlips < ActiveRecord::Migration[7.0]
  def change
    rename_column :salary_slips, :date, :salary_month
  end
end
