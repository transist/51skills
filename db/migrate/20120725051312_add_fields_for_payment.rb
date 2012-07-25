class AddFieldsForPayment < ActiveRecord::Migration
  def up
    add_column :enrollments, :payment_method, :string
    add_column :enrollments, :state, :string
  end

  def down
    remove_column :enrollments, :state
    remove_column :enrollments, :payment_method
  end
end
