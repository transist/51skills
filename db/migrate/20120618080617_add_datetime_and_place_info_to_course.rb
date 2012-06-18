class AddDatetimeAndPlaceInfoToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :start_date_time, :datetime
    add_column :courses, :address, :text
  end
end
