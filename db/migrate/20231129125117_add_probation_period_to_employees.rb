class AddProbationPeriodToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :probation_period, :string
    add_column :employees, :probation_completed_date, :date
  end
end
