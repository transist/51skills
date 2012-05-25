class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_zh

      t.timestamps
    end
  end
end
