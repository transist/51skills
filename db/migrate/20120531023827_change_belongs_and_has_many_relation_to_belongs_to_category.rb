class ChangeBelongsAndHasManyRelationToBelongsToCategory < ActiveRecord::Migration
  def up
    drop_table :categories_courses
    add_column :courses, :category_id, :integer
  end

  def down
    remove_column :courses, :category_id
    create_table :categories_courses do |t|
      t.integer  :category_id
      t.integer  :course_id
      t.timestamps
    end
  end
end
