class AddRateAndFeePercentageToWeeklyHours < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_hours, :rate, :decimal
    add_column :weekly_hours, :fee_percentage, :decimal
  end
end
