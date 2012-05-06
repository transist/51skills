class AddNavToPages < ActiveRecord::Migration
  def change
    add_column :pages, :nav, :boolean, :default => false
  end
end
