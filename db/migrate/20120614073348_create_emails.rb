class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :subject
      t.string :to_address
      t.string :template_name
      t.text :info

      t.timestamps
    end
  end
end
