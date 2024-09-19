# frozen_string_literal: true

require "test_helper"

class LikeTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
    should belong_to(:person)
  end

  context "validations" do
    setup do
      @user = create(:adopter)
      @pet = create(:pet)
      @like = Like.create!(person: @user.person, pet: @pet)
    end

    should validate_uniqueness_of(:person_id).scoped_to(:pet_id)
  end
end
