class AddCourseIdToCourseSession < ActiveRecord::Migration
  def change
    add_column :course_sessions, :course_id, :integer
  end
end
