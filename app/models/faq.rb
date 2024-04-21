# == Schema Information
#
# Table name: faqs
#
#  id              :bigint           not null, primary key
#  answer          :text             not null
#  order           :integer
#  question        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_faqs_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Faq < ApplicationRecord
  acts_as_tenant(:organization)

  validates :question, presence: true
  validates :answer, presence: true
end
