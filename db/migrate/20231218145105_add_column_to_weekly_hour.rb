class AddColumnToWeeklyHour < ActiveRecord::Migration[7.0]
  def change
     add_column :weekly_hours, :week_date, :date
  end
end
