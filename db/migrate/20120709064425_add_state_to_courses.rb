class AddStateToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :state, :string
  end
end
