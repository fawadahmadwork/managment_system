class RemoveColumnsFromSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :salary_detail_histories, :salary_structure_id
    remove_column :salary_detail_histories, :name
  end
end
