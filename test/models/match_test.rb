# frozen_string_literal: true

require "test_helper"

class MatchTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
    should belong_to(:adopter_account)
  end

  def test_match_must_belong_to_same_organization_as_pet
    org1 = Organization.create!
    org2 = Organization.create!
    pet = Pet.create!(organization: org1,
      name: "Harry", birth_date: 5.years.ago, size: "small", breed: "corgi", sex: "m", description: "test pet")
    match = Match.create(pet: pet, organization_id: org2.id,
      adopter_account: create(:adopter_account))
    assert !match.valid?
    assert match.errors[:organization_id].present?
  end
end
