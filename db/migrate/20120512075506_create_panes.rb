class CreatePanes < ActiveRecord::Migration
  def change
    create_table :panes do |t|
      t.integer :collage_id
      t.integer :glueable_id
      t.string :glueable_type
      t.integer :showable_id
      t.string :showable_type

      t.timestamps
    end
  end
end
