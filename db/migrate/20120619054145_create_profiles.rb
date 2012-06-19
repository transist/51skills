class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :person_id
      t.text :about

      t.timestamps
    end
  end
end
