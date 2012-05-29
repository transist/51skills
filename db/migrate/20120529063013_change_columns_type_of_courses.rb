class ChangeColumnsTypeOfCourses < ActiveRecord::Migration
  def up
    change_column :courses, :description_en, :text
    change_column :courses, :description_zh, :text
    change_column :courses, :summary_en, :text
    change_column :courses, :summary_zh, :text
  end

  def down
    change_column :courses, :description_en, :string
    change_column :courses, :description_zh, :string
    change_column :courses, :summary_en, :string
    change_column :courses, :summary_zh, :string
  end
end