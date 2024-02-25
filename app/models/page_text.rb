# == Schema Information
#
# Table name: page_texts
#
#  id              :bigint           not null, primary key
#  about           :text
#  hero            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_page_texts_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class PageText < ApplicationRecord
  acts_as_tenant(:organization)
end
