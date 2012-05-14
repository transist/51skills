class ChangeUrlColumnName < ActiveRecord::Migration
  def up
    remove_column :photos, :url
    add_column :photos, :download_url, :string
  end

  def down
    add_column :photos, :url, :string
    remove_column :photos, :download_url
  end
end