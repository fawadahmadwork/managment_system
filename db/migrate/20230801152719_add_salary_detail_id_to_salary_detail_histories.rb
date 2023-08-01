class AddSalaryDetailIdToSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_detail_histories, :salary_detail_id, :bigint
    add_index :salary_detail_histories, :salary_detail_id
  end
end
