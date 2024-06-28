class ChangeCustomPagesToCustomPages < ActiveRecord::Migration[7.1]
  def change
    rename_table :custom_pages, :custom_pages
  end
end
