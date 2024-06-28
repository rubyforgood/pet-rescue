class AddAdoptablePetInfoToCustomPages < ActiveRecord::Migration[7.1]
  def change
    add_column :custom_pages, :adoptable_pet_info, :text
  end
end
