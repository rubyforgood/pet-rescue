# frozen_string_literal: true

class ImageAttachmentTableComponent < ViewComponent::Base
  attr_reader :images

  def initialize(images:)
    @images = images
  end
end
