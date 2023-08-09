class AddEmployeeReferenceToSalaryStructures < ActiveRecord::Migration[7.0]
  def change
    add_reference :salary_structures, :employee, foreign_key: true, optional: true
  end
end
