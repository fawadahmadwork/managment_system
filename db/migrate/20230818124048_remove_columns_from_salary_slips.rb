class RemoveColumnsFromSalarySlips < ActiveRecord::Migration[7.0]
  def change
    remove_column :salary_slips, :allownces
    remove_column :salary_slips, :salary
  end
end
