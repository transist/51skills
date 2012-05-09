class AddIncludeNavToPage < ActiveRecord::Migration
  def change
    add_column :pages, :include_nav, :boolean, :default => true
  end
end
