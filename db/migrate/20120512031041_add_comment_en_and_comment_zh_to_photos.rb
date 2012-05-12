class AddCommentEnAndCommentZhToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :comment_en, :text
    add_column :photos, :comment_zh, :text
  end
end
