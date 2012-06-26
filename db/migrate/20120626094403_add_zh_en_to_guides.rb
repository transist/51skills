class AddZhEnToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :title_zh, :string
    add_column :guides, :title_en, :string
    add_column :guides, :content_zh, :text
    add_column :guides, :content_en, :text
    remove_column :guides, :content    
    remove_column :guides, :title
  end
end
