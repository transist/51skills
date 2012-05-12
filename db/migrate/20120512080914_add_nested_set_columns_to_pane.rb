class AddNestedSetColumnsToPane < ActiveRecord::Migration
  def change
    add_column :panes, :parent_id, :integer
    add_column :panes, :depth, :integer
    add_column :panes, :lft, :integer
    add_column :panes, :rgt, :integer
  end
end