class AddStartingSalaryAndSignupBonusToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :starting_salary, :integer
    add_column :employees, :signup_bonus, :integer
  end
end
