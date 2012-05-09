class AddHeaderToPage < ActiveRecord::Migration
  def change
    add_column :pages, :header, :boolean, :default => true
  end
end
