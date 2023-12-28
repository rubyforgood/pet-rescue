# == Schema Information
#
# Table name: forms
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Form < ApplicationRecord
  has_many :form_questions, dependent: :destroy
  has_many :submissions, dependent: :destroy
end
