class AddColumnToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :date_completed, :date
    add_column :projects, :status, :string
  end
end
