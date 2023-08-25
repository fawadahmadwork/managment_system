class RenameSaalaryStructureIdToEmployeeId < ActiveRecord::Migration[7.0]
  def change
    rename_column :salary_detail_histories,  :employee_id, :salary_structure_id
  end
end
