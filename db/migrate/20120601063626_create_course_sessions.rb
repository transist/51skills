class CreateCourseSessions < ActiveRecord::Migration
  def change
    create_table :course_sessions do |t|
      t.datetime :session_datetime
      t.decimal :duration
      t.string :duration_type
      t.text :location
      t.text :descrption

      t.timestamps
    end
  end
end
