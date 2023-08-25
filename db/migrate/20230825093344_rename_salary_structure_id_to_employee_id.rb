class RenameSalaryStructureIdToEmployeeId < ActiveRecord::Migration[7.0]
  def change
    rename_column :salary_detail_histories, :salary_structure_id, :employee_id
  end
end
