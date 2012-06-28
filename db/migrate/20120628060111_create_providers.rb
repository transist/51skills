class CreateProviders < ActiveRecord::Migration
  def change
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
end
