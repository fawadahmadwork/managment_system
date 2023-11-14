class ChangeHouseRenToHouseRentInSalaryDetailHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :salary_detail_histories, :house_rent,  :house_ren
  end
end
