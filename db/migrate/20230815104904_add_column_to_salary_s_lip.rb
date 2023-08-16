class AddColumnToSalarySLip < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_slips, :basic_salary, :integer
    add_column :salary_slips, :fuel, :integer
    add_column :salary_slips, :medical_allownce, :integer
    add_column :salary_slips, :house_rent, :integer
    add_column :salary_slips, :opd, :integer
    add_column :salary_slips, :arrears, :integer
    add_column :salary_slips, :other_bonus, :integer
    add_column :salary_slips, :gross_salary, :integer
    add_column :salary_slips, :provident_fund, :integer
    add_column :salary_slips, :unpaid_leaves, :integer
    add_column :salary_slips, :net_salary, :integer
    add_column :salary_slips, :name, :string
    add_column :salary_slips, :designation, :string
    add_column :salary_slips, :date_of_joining, :string
  end
end
