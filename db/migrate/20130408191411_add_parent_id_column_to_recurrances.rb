class AddParentIdColumnToRecurrances < ActiveRecord::Migration
  def change
    add_column :recurrances, :parent_id, :string
    add_column :recurrances, :integer, :string
  end
end
