class AddMatchTypeToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :match_type, :integer, null: false
    add_column :matches, :start_date, :datetime
    add_column :matches, :end_date, :datetime
  end
end
