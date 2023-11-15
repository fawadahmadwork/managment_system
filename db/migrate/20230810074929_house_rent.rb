class HouseRent < ActiveRecord::Migration[7.0]
  def change
     rename_column :salary_detail_histories, :house_ren,  :house_rent
  end
end
