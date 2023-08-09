class RemoveSalaryDetailIdFromSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :salary_detail_histories, :salary_detail_id
  end
end
