class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :description
      t.boolean :done
      t.datetime :done_at
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end