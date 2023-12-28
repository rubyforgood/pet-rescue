class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :input_type

      t.timestamps
    end
  end
end
