# == Schema Information
#
# Table name: form_profiles
#
#  id           :bigint           not null, primary key
#  profile_type :string           not null
#  sort_order   :integer          default(0), not null
#  form_id      :bigint           not null
#
# Indexes
#
#  index_form_profiles_on_form_id                   (form_id)
#  index_form_profiles_on_form_id_and_profile_type  (form_id,profile_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class FormProfile < ApplicationRecord
  belongs_to :form

  has_one :organization, through: :form
end
