class AddPersonToLikes < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      add_reference :likes, :person, null: false, foreign_key: true
    end
  end
end
