# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  input_type :integer          default("string")
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  enum input_type: [:string, :boolean, :integer, :array]
  
  has_many :form_questions, dependent: :destroy
  has_many :forms, through: :form_questions
  has_many :responses, dependent: :destroy
end
