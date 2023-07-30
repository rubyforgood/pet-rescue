# == Schema Information
#
# Table name: weights
#
#  id         :bigint           not null, primary key
#  from       :integer
#  to         :integer
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pet_id     :bigint           not null
#
# Indexes
#
#  index_weights_on_pet_id  (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (pet_id => pets.id)
#
class Weight < ApplicationRecord
  belongs_to :pet
  validates :from, presence: {message: "Please enter a from weight"}
  validates :to, presence: {message: "Please enter a to weight"}
  validates :unit, presence: {message: "Please enter a unit"}
  validate :to_weight_must_be_greater_than_from_weight

  def self.units
    ["lb", "kg"]
  end

  def custom_messages(attribute)
    errors.where(attribute)
  end

  def to_weight_must_be_greater_than_from_weight
    if from.present? && to.present?
      errors.add(:to, "Must be greater than from weight") if to < from
    end
  end
end
