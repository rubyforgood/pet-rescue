class ChangePageTextsToCustomPages < ActiveRecord::Migration[7.1]
  def change
    rename_table :page_texts, :custom_pages
  end
end
