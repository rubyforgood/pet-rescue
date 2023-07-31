class Person < ApplicationRecord
  belongs_to :user
  has_one :location, dependent: :destroy
  accepts_nested_attributes_for :location
  validates_associated :location

  before_save :normalize_phone

  # phonelib gem
  validates :phone_number, phone: {possible: true}

  validates :contact_method, presence: true
  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :referral_source, presence: {message: "Please tell us how you heard about us"},
    length: {maximum: 50, message: "50 characters maximum"}

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

  def visiting_laventana?
    visit_laventana == true
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

  # used in views to show only the custom error msg without leading attribute
  def custom_messages(attribute)
    errors.where(attribute)
  end

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
