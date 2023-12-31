class CreatePreTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :pre_todo_items do |t|
      t.string :description
      t.string :type
      t.boolean :done
      t.datetime :done_at
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
