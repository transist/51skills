class AddImageFieldsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :image_content_type, :string
    add_column :courses, :image_file_name, :string
    add_column :courses, :image_file_size, :string
    
    drop_table :panes
    drop_table :photos
    drop_table :collages
  end
end
