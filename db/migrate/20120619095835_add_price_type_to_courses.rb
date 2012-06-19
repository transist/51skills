class AddPriceTypeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :price_type, :string
  end
end
