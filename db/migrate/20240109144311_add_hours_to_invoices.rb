class AddHoursToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :hours, :integer
  end
end
