class AddWeekNoColumnToWeeklyHour < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_hours, :week_number, :string
  end
end
