class CreatePanesPhotos < ActiveRecord::Migration
  def up
    create_table :panes_photos, :force => true do |t|
      t.integer :pane_id
      t.integer :photo_id
    end
  end

  def down
  end
end