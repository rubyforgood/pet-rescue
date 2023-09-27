# frozen_string_literal: true

require "test_helper"

class MatchTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:pet)
    should belong_to(:adopter_account)
  end
end
