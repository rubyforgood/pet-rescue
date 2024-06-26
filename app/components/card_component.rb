# frozen_string_literal: true

# Renders a card component
class CardComponent < ApplicationComponent
  attr_reader :card_options, :image_options, :header_options, :body_options

  # @param card_options [Hash] opts for customizing card
  # @option card_options [Symbol] :class () CSS classes of card container
  # @param image_options [Hash] opts for customizing card image
  # @option image_options [Symbol] :src () Src of image
  # @option image_options [Symbol] :class () CSS classes of img element
  # @option image_options [Symbol] :url () Url to wrap an image in
  # @option image_options [Symbol] :default () Default image src
  # @param header_options [Hash] opts for customizing card header
  # @option header_options [Symbol] :class () CSS classes of card header
  # @param body_options [Hash] opts for customizing card body
  # @option body_options [Symbol] :class () CSS classes of card body
  def initialize(card_options: {}, image_options: {}, header_options: {}, body_options: {})
    @card_options = card_options
    @image_options = image_options
    @header_options = header_options
    @body_options = body_options
  end

  renders_one :header
  renders_one :body
  renders_one :badge

  private

  def card_class
    @card_class ||= card_options[:class] || "card card-hover"
  end

  def image_src
    @image_src ||= image_options[:src] || image_default
  end

  def image_class
    @image_class ||= image_options[:class] || "card-img-top"
  end

  def image_url
    @image_url ||= image_options[:url]
  end

  def header_class
    @header_class ||= header_options[:class] || "card-header"
  end

  def body_class
    @body_class ||= body_options[:class] || "card-body"
  end

  def image_default
    @image_default ||= image_options[:default] || "coming_soon.jpg"
  end
end
