# == Schema Information
#
# Table name: answers
#
#  id                :bigint           not null, primary key
#  question_snapshot :json             not null
#  value             :json             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_id       :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_one :form, through: :question
  has_one :organization, through: :form
end
