class ChangeRawPostToRawData < ActiveRecord::Migration
  def up
    remove_column :pay_fu_transactions, :raw_post
    add_column :pay_fu_transactions, :raw_data, :text
  end

  def down
    remove_column :pay_fu_transactions, :raw_data
    add_column :pay_fu_transactions, :raw_post, :text
  end
end
