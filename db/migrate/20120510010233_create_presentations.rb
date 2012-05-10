class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.integer :page_id
      t.integer :width
      t.integer :height
      

      t.timestamps
    end
  end
end
