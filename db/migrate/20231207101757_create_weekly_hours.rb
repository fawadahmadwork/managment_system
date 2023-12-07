class CreateWeeklyHours < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_hours do |t|
      t.references :project, null: false, foreign_key: true
      t.decimal :hours
      t.decimal :external_rate

      t.timestamps
    end
  end
end
