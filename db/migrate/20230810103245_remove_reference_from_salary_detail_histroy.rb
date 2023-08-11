class RemoveReferenceFromSalaryDetailHistroy < ActiveRecord::Migration[7.0]
  def change
    remove_reference :salary_detail_histories, :employee, null: false, foreign_key: true
  end
end
