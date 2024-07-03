class AddAdoptablePetInfoToCustomPages < ActiveRecord::Migration[7.1]
  def change
    add_column :page_texts, :adoptable_pet_info, :text
  end
end
