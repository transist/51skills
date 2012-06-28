class RenameEmailColumnToPeople < ActiveRecord::Migration
  def up
    rename_column :people, :email, :email_address
  end
end
