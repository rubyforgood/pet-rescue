# == Schema Information
#
# Table name: submissions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  form_id         :bigint           not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_submissions_on_form_id          (form_id)
#  index_submissions_on_organization_id  (organization_id)
#  index_submissions_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
class Submission < ApplicationRecord
  belongs_to :form
  belongs_to :user

  has_many :responses, dependent: :destroy

  acts_as_tenant(:organization)
end
