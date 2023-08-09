class AddColumnToSalaryDetailHistory < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_detail_histories, :basic_salary, :integer
    add_column :salary_detail_histories, :fuel, :integer
    add_column :salary_detail_histories, :medical_allownce, :integer
    add_column :salary_detail_histories, :house_ren, :integer
    add_column :salary_detail_histories, :opd, :integer
    add_column :salary_detail_histories, :arrears, :integer
    add_column :salary_detail_histories, :other_bonus, :integer
    add_column :salary_detail_histories, :gross_salary, :integer
    add_column :salary_detail_histories, :provident_fund, :integer
    add_column :salary_detail_histories, :unpaid_leaves, :integer
    add_column :salary_detail_histories, :net_salary, :integer
    add_reference :salary_detail_histories, :employee, foreign_key: true
  end
end
