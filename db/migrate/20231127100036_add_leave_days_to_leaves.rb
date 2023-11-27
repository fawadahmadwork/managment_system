class AddLeaveDaysToLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :leave_days, :decimal
  end
end
