class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :presentation_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
  end
end
