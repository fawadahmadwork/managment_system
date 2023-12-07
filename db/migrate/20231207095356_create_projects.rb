class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :project_type
      t.string :billing_type
      t.string :source
      t.decimal :rate
      t.decimal :fee_percentage
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end
  end
end
