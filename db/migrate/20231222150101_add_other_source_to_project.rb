class AddOtherSourceToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :source_detail, :string
  end
end
