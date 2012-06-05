class ChangeFieldsInCourseSession < ActiveRecord::Migration
  def up
    remove_column :course_sessions, :descrption
    add_column :course_sessions, :description_zh, :text
    add_column :course_sessions, :description_en, :text
    add_column :course_sessions, :searchable_description_zh, :text    
  end

  def down
    remove_column :course_sessions, :searchable_description_zh
    remove_column :course_sessions, :description_en
    remove_column :course_sessions, :description_zh
    add_column :course_sessions, :descrption, :text
  end
end
