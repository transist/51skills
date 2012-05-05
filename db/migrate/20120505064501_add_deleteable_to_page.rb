class AddDeleteableToPage < ActiveRecord::Migration
  def change
    add_column :pages, :deleteable, :boolean, :default => true
    add_column :pages, :root, :boolean, :default => false
  end
end
