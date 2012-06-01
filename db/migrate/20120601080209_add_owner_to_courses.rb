class AddOwnerToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :owner_id, :integer
  end
end
