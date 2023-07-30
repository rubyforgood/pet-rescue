# frozen_string_literal: true

require "test_helper"

class PetTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:adopter_applications).dependent(:destroy)
    should have_one(:match).dependent(:destroy)
    should have_one(:weight).dependent(:destroy)
    should have_many_attached(:images)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:birth_date)
    should validate_presence_of(:breed)
    should validate_presence_of(:sex)
    should validate_presence_of(:description)
    should validate_length_of(:description).is_at_most(1000)
  end

  context "#has_adoption_pending?" do
    should "return true if there is an adopter application with 'adoption_pending' status" do
      pet = Pet.new
      adopter_application = pet.adopter_applications.new
      adopter_application.status = "adoption_pending"
      assert pet.has_adoption_pending?

      adopter_application.status = "awaiting_review"
      assert_not pet.has_adoption_pending?
    end
  end
end
