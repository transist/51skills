class ChangeDefaultForPageDepth < ActiveRecord::Migration
  def up
    change_column :pages, :depth, :integer, :default => 1
  end

  def down
    change_column :pages, :depth, :integer, :default => 0
  end
end