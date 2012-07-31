class ChangePayFuTransactionsRawPostToText < ActiveRecord::Migration
  def up
    change_column :pay_fu_transactions, :raw_post, :text
  end

  def down
    change_column :pay_fu_transactions, :raw_post, :string
  end
end
