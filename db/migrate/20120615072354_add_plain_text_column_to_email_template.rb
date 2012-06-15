class AddPlainTextColumnToEmailTemplate < ActiveRecord::Migration
  def change
    add_column :email_templates, :text, :text
  end
end
