class AddExpiresAtToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :expires_at, :string
  end
end
