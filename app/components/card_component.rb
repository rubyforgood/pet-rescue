# frozen_string_literal: true

# Renders a card component
class CardComponent < ApplicationComponent
  # @!attribute [r] card_options
  #   @return [Hash] the card options including CSS classes for the card container.
  option :card_options,
    Types::Hash.schema(
      class?: Types::String.default("card card-hover")
    ),
    default: -> { {} }

  # @!attribute [r] header_options
  #   @return [Hash] the header options including CSS classes.
  option :header_options,
    Types::Hash.schema(
      class?: Types::String.default("card-header")
    ),
    default: -> { {} }

  # @!attribute [r] body_options
  #   @return [Hash] the body options including CSS classes.
  option :body_options,
    Types::Hash.schema(
      class?: Types::String.default("card-body")
    ),
    default: -> { {} }

  # @!attribute [r] image_options
  #   @return [Hash] the image options including the src for image_tag, CSS classes, URL to wrap around the image, and a default image src.
  option :image_options,
    Types::Hash.schema(
      src?: Types::Nominal::Any,
      class?: Types::String.default("card-img-top"),
      url?: Types::String,
      default?: Types::Nominal::Any.default("coming_soon.jpg")
    ),
    default: -> { {} }

  renders_one :header
  renders_one :body
  renders_one :badge

  private

  def image_src
    @image_src ||= image_options[:src] || image_options[:default]
  end
end
