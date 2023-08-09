class AddNewColumnToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :freezing_date, :date
    add_column :employees, :freezing_comment, :string
  end
end
