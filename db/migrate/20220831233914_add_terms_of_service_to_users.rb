class AddTermsOfServiceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tos_agreement, :boolean
  end
end
