class AddHiddenToPage < ActiveRecord::Migration
  def change
    add_column :pages, :hidden, :boolean, :default => true
  end
end
