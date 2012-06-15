class AddCodeToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :code, :string
  end
end
