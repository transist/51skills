class RemoveSearchableEnColumnsAndAddNameToCourse < ActiveRecord::Migration
  def up
    remove_column :courses, :searchable_summary_en
    remove_column :courses, :searchable_description_en
    add_column :courses, :searchable_name_zh, :text
  end

  def down
    add_column :courses, :searchable_summary_en, :text
    add_column :courses, :searchable_description_en, :text
    remove_column :courses, :searchable_name_zh
  end
end
