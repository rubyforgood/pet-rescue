# == Schema Information
#
# Table name: page_texts
#
#  id                 :bigint           not null, primary key
#  about              :text
#  adoptable_pet_info :text
#  hero               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  organization_id    :bigint           not null
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

  has_one_attached :hero_image
  has_many_attached :about_us_images

  validates :hero, presence: true, allow_nil: true
  validates :about, presence: true, allow_nil: true

  validates :hero_image, content_type: ["image/png", "image/jpeg"],
    limit: {max: 1},
    size: {less_than: 2.megabytes}

  validates :about_us_images, content_type: ["image/png", "image/jpeg"],
    limit: {max: 2},
    size: {less_than: 2.megabytes}

  def images
    [hero_image.attached? ? hero_image : nil].compact + about_us_images.to_a
  end
end
