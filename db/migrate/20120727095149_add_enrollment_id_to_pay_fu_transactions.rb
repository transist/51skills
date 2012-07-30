class AddEnrollmentIdToPayFuTransactions < ActiveRecord::Migration
  def change
    add_column :pay_fu_transactions, :enrollment_id, :integer
  end
end
