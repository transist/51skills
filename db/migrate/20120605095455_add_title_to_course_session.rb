class AddTitleToCourseSession < ActiveRecord::Migration
  def change
    add_column :course_sessions, :title_en, :string
    add_column :course_sessions, :title_zh, :string
  end
end
