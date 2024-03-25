# == Schema Information
#
# Table name: forms
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  description     :text
#  instructions    :text
#  name            :string           not null
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_forms_on_organization_id            (organization_id)
#  index_forms_on_organization_id_and_name   (organization_id,name) UNIQUE
#  index_forms_on_organization_id_and_title  (organization_id,title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Form < ApplicationRecord
  belongs_to :organization

  has_many :form_profiles, dependent: :destroy
  has_many :questions, -> { ordered }, dependent: :destroy
end
