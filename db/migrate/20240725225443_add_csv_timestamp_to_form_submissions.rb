class AddCsvTimestampToFormSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :form_submissions, :csv_timestamp, :datetime
  end
end
