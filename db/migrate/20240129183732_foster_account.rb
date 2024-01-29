class FosterAccount < ActiveRecord::Migration[7.0]
  def change
    create_table :foster_accounts do |t|
      t.references :user, foreign_key: true
    end
  end
end
