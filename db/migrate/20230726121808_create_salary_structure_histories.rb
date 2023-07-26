class CreateSalaryStructureHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :salary_structure_histories do |t|
      t.string :name
      t.integer :salary
      t.integer :allowances
      t.references :salary_structure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
