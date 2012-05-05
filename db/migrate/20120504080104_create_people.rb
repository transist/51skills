class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :uid
      t.string :username
      t.string :token
      t.string :secret
      t.string :provider
      t.text :profile_attributes

      t.timestamps
    end
  end
end
