class CreateCollages < ActiveRecord::Migration
  def change
    create_table :collages do |t|
      t.integer :page_id
      t.string :name
      t.text :config

      t.timestamps
    end
  end
end
