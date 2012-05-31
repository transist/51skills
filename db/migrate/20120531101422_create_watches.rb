class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.integer :person_id
      t.integer :course_id

      t.timestamps
    end
  end
end
