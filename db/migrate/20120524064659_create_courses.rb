class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name_en
      t.string :name_zh
      t.string :description_en
      t.string :description_zh
      t.string :summary_en
      t.string :summary_zh
      t.string :weibo
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :github

      t.timestamps
    end
  end
end
