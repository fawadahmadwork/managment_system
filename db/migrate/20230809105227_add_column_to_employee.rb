class AddColumnToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :employment_type, :string
  end
end
