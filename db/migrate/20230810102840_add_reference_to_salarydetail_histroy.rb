class AddReferenceToSalarydetailHistroy < ActiveRecord::Migration[7.0]
  def change
    add_reference :salary_detail_histories, :salary_structure, foreign_key: true
  end
end
