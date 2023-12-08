class AddDateToWeeklyHour < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_hours, :date, :date
  end
end