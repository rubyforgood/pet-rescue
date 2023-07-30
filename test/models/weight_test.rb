# frozen_string_literal: true

require "test_helper"

class WeightTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
  end

  context "validations" do
    should validate_presence_of(:from)
    should validate_presence_of(:to)
    should validate_presence_of(:unit)
  end
end
