class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image_content_type
      t.string :image_file_name
      t.integer :image_file_size

      t.timestamps
    end
  end
end
