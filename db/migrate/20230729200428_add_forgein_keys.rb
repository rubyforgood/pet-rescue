class AddForgeinKeys < ActiveRecord::Migration[7.0]
  def change
    add_reference :adopter_applications, :person
    add_reference :people, :user
    add_reference :matches, :person
  end
end
