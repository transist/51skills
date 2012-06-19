class AddAvatarToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :avatar_content_type, :string
    add_column :profiles, :avatar_file_name, :string
    add_column :profiles, :avatar_file_size, :string
  end

  def self.down
    remove_column :profiles, :avatar_content_type
    remove_column :profiles, :avatar_file_name
    remove_column :profiles, :avatar_file_size
  end
end
