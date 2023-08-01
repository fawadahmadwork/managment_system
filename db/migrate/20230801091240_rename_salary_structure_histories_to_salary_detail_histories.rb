class RenameSalaryStructureHistoriesToSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    rename_table :salary_structure_histories, :salary_detail_histories
  end
end
