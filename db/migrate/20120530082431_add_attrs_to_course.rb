class AddAttrsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :difficulty, :string
  end
end
