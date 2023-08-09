class AddColumnToSalaryStructure < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_structures, :basic_salary, :integer
    add_column :salary_structures, :fuel, :integer
    add_column :salary_structures, :medical_allownce, :integer
    add_column :salary_structures, :house_rent, :integer
    add_column :salary_structures, :opd, :integer
    add_column :salary_structures, :arrears, :integer
    add_column :salary_structures, :other_bonus, :integer
    add_column :salary_structures, :gross_salary, :integer
    add_column :salary_structures, :provident_fund, :integer
    add_column :salary_structures, :unpaid_leaves, :integer
    add_column :salary_structures, :net_salary, :integer
  end
end
