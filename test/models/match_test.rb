# frozen_string_literal: true

require "test_helper"

class MatchTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
    should belong_to(:adopter_foster_account)
  end

  setup do
    @match = build_stubbed(:match)
  end

  context "#withdraw_application" do
    setup do
      @application = mock("adopter_application")
    end

    should "send #withdraw to application" do
      @match.expects(:adopter_application).returns(@application)
      @application.expects(:withdraw)

      @match.withdraw_application
    end
  end

  context "#retire_applications" do
    setup do
      @application_class = mock("AdopterApplication")
    end

    should "send #retire_applications with pet_id to application_class" do
      @application_class.expects(:retire_applications).with(pet_id: @match.pet_id)

      @match.retire_applications(application_class: @application_class)
    end
  end
end
