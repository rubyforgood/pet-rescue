class DropDonations < ActiveRecord::Migration[7.1]
  def change
    drop_table :donations
  end
end
