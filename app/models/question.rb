# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  input_type :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  has_many :form_questions, dependent: :destroy
  has_many :responses, dependent: :destroy
end
