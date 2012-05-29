class AddColumnsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :searchable_summary_en, :text
    add_column :courses, :searchable_summary_zh, :text
    add_column :courses, :searchable_description_en, :text
    add_column :courses, :searchable_description_zh, :text
  end
end