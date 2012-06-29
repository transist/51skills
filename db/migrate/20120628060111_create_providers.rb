class CreateProviders < ActiveRecord::Migration
  def up
    drop_table :providers
    create_table :providers do |t|
      t.string :uid
      t.string :username
      t.string :token
      t.string :secret
      t.string :provider
      t.text :profile_attributes
      t.string :email
      t.integer :person_id

      t.timestamps
    end
  end
  
  def down
    drop_table :providers
  end
end
