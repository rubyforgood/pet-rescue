# frozen_string_literal: true

require "test_helper"

class MatchTest < ActiveSupport::TestCase
  setup do
    @match = build_stubbed(:match)
  end

  context "associations" do
    should belong_to(:pet)
    should belong_to(:person)
  end

  context "validations" do
    should define_enum_for(:match_type)
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

  context "status" do
    context "when end date is less than current time" do
      setup do
        @start_date = Time.current - 10.day
        @end_date = Time.current - 1.day
        @match = create(:match, start_date: @start_date, end_date: @end_date)
      end

      should "return :complete" do
        assert_equal :complete, @match.status
      end
    end

    context "when start date is greater than current time" do
      setup do
        @start_date = Time.current + 1.day
        @end_date = Time.current + 3.day
        @match = create(:match, start_date: @start_date, end_date: @end_date)
      end

      should "return :upcoming" do
        assert_equal :upcoming, @match.status
      end
    end

    context "when current time is between start and end date" do
      setup do
        @start_date = Time.current - 1.day
        @end_date = Time.current + 1.day
        @match = create(:match, start_date: @start_date, end_date: @end_date)
      end

      should "return :current" do
        assert_equal :current, @match.status
      end
    end

    context "when start_date is nil" do
      setup do
        @match = create(:match, start_date: nil, end_date: nil)
      end

      should "return :not_applicable" do
        assert_equal :not_applicable, @match.status
      end
    end

    context "when end_date is nil" do
      setup do
        @match = create(:match, start_date: nil, end_date: nil)
      end

      should "return :not_applicable" do
        assert_equal :not_applicable, @match.status
      end
    end
  end
end
