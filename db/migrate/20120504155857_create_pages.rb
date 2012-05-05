class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title_en
      t.string :title_zh
      t.string :content_en
      t.string :content_zh
      t.string :slug

      t.timestamps
    end
  end
end
