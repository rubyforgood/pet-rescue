class Dog < ApplicationRecord
  belongs_to :organization
  has_many :adopter_applications
  has_one :adoption
  has_many_attached :images

  validates :name, presence: true, uniqueness: true
  validates :age, presence: true
  validates :size, presence: true
  validates :breed, presence: true
  validates :sex, presence: true
  validates :description, presence: true, length: { maximum: 500 }

  # active storage validations gem
  validates :images, content_type: { in: ['image/png', 'image/jpeg'], message: 'must be PNG or JPEG' },
                     limit: { max: 5, message: '- 5 maximum' },
                     size: { between: 100.kilobyte..2.megabytes,
                             message: 'file size must be between 100kb and 2Mb' }

  # using.attach per the recommendation in rails server output for appending images
  def append_images=(attachables)
    images.attach(attachables)
  end

  def self.org_dogs(user_org_id)
    Dog.where(organization_id: user_org_id)
  end

  def self.org_dogs_with_apps(user_org_id)
    Dog.org_dogs(user_org_id).includes(:adopter_applications).where.not(adopter_applications: { id: nil })
       .includes(:adoption).where(adoption: { id: nil })
  end


end
