class ChangeColumnsOnPages < ActiveRecord::Migration
  def up
    change_column :pages, :content_zh, :text
    change_column :pages, :content_en, :text
  end

  def down
    change_column :pages, :content_zh, :string
    change_column :pages, :content_en, :string
  end
end