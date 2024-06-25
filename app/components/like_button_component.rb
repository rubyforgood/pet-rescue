# frozen_string_literal: true

class LikeButtonComponent < ViewComponent::Base
  attr_reader :like, :pet

  def initialize(like:, pet:)
    @like = like
    @pet = pet
  end
end
