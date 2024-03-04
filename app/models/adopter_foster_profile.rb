# == Schema Information
#
# Table name: adopter_foster_profiles
#
#  id                 :bigint           not null, primary key
#  activities         :text
#  adults_in_home     :integer
#  alone_weekday      :integer
#  alone_weekend      :integer
#  annual_cost        :string
#  checked_shelter    :boolean
#  city_town          :string
#  contact_method     :string
#  contingency_plan   :text
#  country            :string
#  describe_pets      :text
#  describe_surrender :text
#  do_you_rent        :boolean
#  experience         :text
#  fenced_access      :boolean
#  fenced_alternative :text
#  housing_type       :string
#  ideal_pet          :text
#  kids_in_home       :integer
#  lifestyle_fit      :text
#  location_day       :text
#  location_night     :text
#  other_pets         :boolean
#  pets_allowed       :boolean
#  phone_number       :string
#  province_state     :string
#  referral_source    :text
#  shared_owner       :text
#  shared_ownership   :boolean
#  surrendered_pet    :boolean
#  visit_dates        :text
#  visit_laventana    :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adopter_account_id :bigint           not null
#  foster_account_id  :bigint
#  location_id        :bigint           not null
#
# Indexes
#
#  index_adopter_foster_profiles_on_adopter_account_id  (adopter_account_id)
#  index_adopter_foster_profiles_on_foster_account_id   (foster_account_id)
#  index_adopter_foster_profiles_on_location_id         (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (adopter_account_id => adopter_accounts.id)
#  fk_rails_...  (foster_account_id => foster_accounts.id)
#  fk_rails_...  (location_id => locations.id)
#
class AdopterFosterProfile < ApplicationRecord
  belongs_to :location, dependent: :destroy
  belongs_to :adopter_account
  belongs_to :foster_account, class_name: "User", foreign_key: :adopter_account_id
  accepts_nested_attributes_for :location
  validates_associated :location

  before_save :normalize_phone

  # phonelib gem
  validates :phone_number, phone: {possible: true}

  validates :contact_method, presence: true
  validates :ideal_pet, presence: {length: {maximum: 200,
                                            message: I18n.t("errors.attributes.general.200_characters_maximum")}}
  validates :lifestyle_fit, presence: {length: {maximum: 200,
                                                message: I18n.t("errors.attributes.general.200_characters_maximum")}}
  validates :activities, presence: {length: {maximum: 200,
                                             message: I18n.t("errors.attributes.general.200_characters_maximum")}}
  validates :alone_weekday, presence: true
  validates :alone_weekend, presence: true
  validates :experience, presence: {length: {maximum: 200,
                                             message: I18n.t("errors.attributes.general.200_characters_maximum")}}
  validates :contingency_plan, presence: {length: {maximum: 200,
                                                   message: I18n.t("errors.attributes.general.200_characters_maximum")}}
  validates_inclusion_of :shared_ownership, in: [true, false]
  validates :shared_owner, presence: {length: {maximum: 200,
                                               message: I18n.t("errors.attributes.general.200_characters_maximum")}},
    if: :shared_owner_true?
  validates :housing_type, presence: true
  validates_inclusion_of :fenced_access, in: [true, false]
  validates :fenced_alternative, presence: {length: {maximum: 200,
                                                     message: I18n.t("errors.attributes.general.200_characters_maximum")}},
    if: :fenced_access_false?
  validates :location_day, presence: true, length: {maximum: 100}
  validates :location_night, presence: true, length: {maximum: 100}
  validates_inclusion_of :do_you_rent, in: [true, false]
  validates_inclusion_of :pets_allowed, in: [true, false], if: :do_you_rent?
  validates :adults_in_home, presence: true
  validates :kids_in_home, presence: true
  validates_inclusion_of :other_pets, in: [true, false]
  validates :describe_pets, presence: {length: {maximum: 200,
                                                message: I18n.t("errors.attributes.general.200_characters_maximum")}},
    if: :other_pets?
  validates_inclusion_of :checked_shelter, in: [true, false]
  validates_inclusion_of :surrendered_pet, in: [true, false]
  validates :describe_surrender, presence: {length: {maximum: 200,
                                                     message: I18n.t("errors.attributes.general.200_characters_maximum")}},
    if: :surrendered_pet?
  validates :annual_cost, presence: true
  validates_inclusion_of :visit_laventana, in: [true, false]
  validates :visit_dates, presence: {length: {maximum: 50,
                                              message: I18n.t("errors.attributes.general.50_characters_maximum")}},
    if: :visiting_laventana?
  validates :referral_source, presence: {length: {maximum: 50,
                                                  message: I18n.t("errors.attributes.general.50_characters_maximum")}}

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
