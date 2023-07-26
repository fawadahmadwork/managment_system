class CreateSalaryStructures < ActiveRecord::Migration[7.0]
  def change
    create_table :salary_structures do |t|
      t.string :name
      t.integer :salary
      t.integer :allowances
      t.references :employee, null: false, foreign_key: true
      t.timestamps
    end
  end
end
