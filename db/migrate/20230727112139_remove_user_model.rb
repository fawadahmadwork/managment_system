class RemoveUserModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :users
    # If there are any other associated columns, you can remove them here as well.
    # For example:
    # remove_column :another_table, :user_id
  end
end
