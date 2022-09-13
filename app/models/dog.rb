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
  validates :images, content_type: { in: ['image/png', 'image/jpeg'],
                                     message: 'must be PNG or JPEG' },
                     limit: { max: 5, message: '- 5 maximum' },
                     size: { between: 100.kilobyte..2.megabytes,
                             message: 'size must be between 100kb and 2Mb' }

  # active storage: using.attach for appending images per rails guide
  def append_images=(attachables)
    images.attach(attachables)
  end

  # all dogs under an organization
  def self.org_dogs(staff_org_id)
    Dog.where(organization_id: staff_org_id)
  end

  # all dogs under an organization with applications and no adoptions
  def self.org_dogs_with_apps(staff_org_id)
    Dog.org_dogs(staff_org_id).includes(:adopter_applications).where
       .not(adopter_applications: { id: nil }).includes(:adoption)
       .where(adoption: { id: nil })
  end

  # all unadopted dogs under all organizations
  def self.all_unadopted_dogs
    Dog.includes(:adoption).where(adoption: { id: nil })
  end

  # all unadopted dogs under an organization
  def self.unadopted_dogs(staff_org_id)
    Dog.org_dogs(staff_org_id).includes(:adoption).where(adoption: { id: nil })
  end

  # all adopted dogs under an organization
  def self.adopted_dogs(staff_org_id)
    Dog.org_dogs(staff_org_id).includes(:adoption)
       .where.not(adoption: { id: nil })
  end
end
