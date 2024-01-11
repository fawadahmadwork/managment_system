class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :project, foreign_key: true
      t.references :weekly_hour, foreign_key: true
      t.date :due_date
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 'initiated'
      t.string :amount

      t.timestamps
    end
  end
end
