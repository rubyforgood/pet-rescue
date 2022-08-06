class AddNotesToAdopterApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_applications, :notes, :text
  end
end
