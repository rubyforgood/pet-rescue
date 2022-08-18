class AdopterProfile < ApplicationRecord
  belongs_to :adopter_account
  before_save :normalize_phone

  validates :phone_number, phone: { possible: true }
  validates :contact_method, presence: true
  validates :country, presence: true
  validates :province_state, presence: true
  validates :city_town, presence: true
  validates :ideal_dog, presence: true, length: { maximum: 200 }
  validates :lifestyle_fit, presence: true, length: { maximum: 200 }
  validates :activities, presence: true, length: { maximum: 200 }
  validates :alone_weekday, presence: true
  validates :alone_weekend, presence: true
  validates :experience, presence: true, length: { maximum: 200 }
  validates :contingency_plan, presence: true, length: { maximum: 200 }
  validates_inclusion_of :shared_ownership, in: [true, false], message: "can't be blank"
  validates :shared_owner, length: { maximum: 200 }
  validates :shared_owner, presence: true, if: :shared_owner_true?
  validates :housing_type, presence: true
  validates_inclusion_of :fenced_access, in: [true, false], message: "can't be blank"
  validates :fenced_alternative, length: { maximum: 200 }
  validates :fenced_alternative, presence: true, if: :fenced_access_false?
  validates :location_day, presence: true, length: { maximum: 50 }
  validates :location_night, presence: true, length: { maximum: 50 }
  validates_inclusion_of :do_you_rent, in: [true, false], message: "can't be blank"
  validates_inclusion_of :dogs_allowed, in: [true, false], message: "can't be blank", if: :do_you_rent?
  validates :adults_in_home, presence: true
  validates :kids_in_home, presence: true
  validates_inclusion_of :other_pets, in: [true, false], message: "can't be blank"
  validates :describe_pets, length: { maximum: 200 }
  validates :describe_pets, presence: true, if: :other_pets?
  validates_inclusion_of :checked_shelter, in: [true, false], message: "can't be blank"
  validates_inclusion_of :surrendered_pet, in: [true, false], message: "can't be blank"
  validates :describe_surrender, length: { maximum: 200 }
  validates :describe_surrender, presence: true, if: :surrendered_pet?
  validates :annual_cost, presence: true

  def shared_owner_true?
    shared_ownership == true
  end

  def fenced_access_false?
    fenced_access == false
  end

  def do_you_rent?
    do_you_rent == true
  end

  def other_pets?
    other_pets == true
  end

  def surrendered_pet?
    surrendered_pet == true
  end

  def formatted_phone
    parsed_phone = Phonelib.parse(phone_number)
    return phone_number if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == "1" # NANP
        parsed_phone.full_national # (415) 555-2671;123
      else
        parsed_phone.full_international # +44 20 7183 8750
      end
    formatted.gsub!(";", " x") # (415) 555-2671 x123
    formatted
  end

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
