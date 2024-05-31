# frozen_string_literal: true

require "test_helper"

class PetTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:adopter_applications).dependent(:destroy)
    should have_many(:matches).dependent(:destroy)
    should have_many_attached(:images)
    should have_many(:likes).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:birth_date)
    should validate_presence_of(:breed)
    should validate_presence_of(:sex)
    should validate_presence_of(:species)
    should validate_presence_of(:placement_type)
    should validate_presence_of(:description)
    should validate_length_of(:description).is_at_most(1000)
    should validate_presence_of(:weight_from)
    should validate_numericality_of(:weight_from).only_integer
    should validate_presence_of(:weight_to)
    should validate_numericality_of(:weight_to).only_integer
    should validate_presence_of(:weight_unit)
    should validate_inclusion_of(:weight_unit).in_array(["lb", "kg"])
    should define_enum_for(:species)
    should define_enum_for(:placement_type)
  end

  context "scopes" do
    context ".org_pets_with_apps(staff_org_id)" do
      should "return pets for organization that have adopter applications" do
        pet_with_app = create(:pet, :adoption_pending)
        pet_without_app = create(:pet)
        res = Pet.org_pets_with_apps(ActsAsTenant.current_tenant.id)

        assert res.include?(pet_with_app)
        assert_not res.include?(pet_without_app)
      end

      should "include pets that have been adopted" do
        adopted_pet = create(:pet, :adopted)
        res = Pet.org_pets_with_apps(ActsAsTenant.current_tenant.id)

        assert res.include?(adopted_pet)
      end
    end

    context ".with_photo" do
      should "return pets that have a photo on their profile" do
        pet_with_image = create(:pet, :with_image)
        pet_without_image = create(:pet)

        assert Pet.with_photo.include?(pet_with_image)
        assert_not Pet.with_photo.include?(pet_without_image)
      end
    end
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

  context "#is_adopted?" do
    should "return true if there is an adopter application with 'adoption_pending' status" do
      pet = Pet.new
      adopter_application = pet.adopter_applications.new
      adopter_application.status = "adoption_made"
      assert pet.is_adopted?

      adopter_application.status = "awaiting_review"
      assert_not pet.is_adopted?
    end
  end
end
