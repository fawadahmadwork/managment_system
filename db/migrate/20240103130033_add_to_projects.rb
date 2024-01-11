class AddToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :due_duration, :integer
    add_column :projects, :weekly_payment, :boolean
  end
end
