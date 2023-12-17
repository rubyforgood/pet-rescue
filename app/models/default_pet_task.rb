# == Schema Information
#
# Table name: default_pet_tasks
#
#  id              :bigint           not null, primary key
#  description     :string           not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
class DefaultPetTask < ApplicationRecord
  acts_as_tenant(:organization)

  validates :name, presence: true
  validates :description, presence: true
end
