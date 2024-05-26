# frozen_string_literal: true

require "test_helper"

class LikeTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
    should belong_to(:adopter_foster_account)
  end

  context "validations" do
    setup do
      @user = create(:adopter)
      @pet = create(:pet)
      @like = Like.create!(adopter_foster_account: @user.adopter_foster_account, pet: @pet)
    end

    should validate_uniqueness_of(:adopter_foster_account_id).scoped_to(:pet_id)
  end
end
