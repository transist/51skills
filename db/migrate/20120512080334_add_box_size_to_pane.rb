class AddBoxSizeToPane < ActiveRecord::Migration
  def change
    add_column :panes, :box_size, :string
  end
end
