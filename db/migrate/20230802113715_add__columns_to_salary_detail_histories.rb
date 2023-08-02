class AddColumnsToSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :salary_detail_histories, :name, :string
  end
end
