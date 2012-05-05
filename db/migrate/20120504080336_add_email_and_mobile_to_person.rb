class AddEmailAndMobileToPerson < ActiveRecord::Migration
  def change
    add_column :people, :email, :string
    add_column :people, :mobile, :string
  end
end
