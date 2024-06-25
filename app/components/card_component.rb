# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  attr_reader :card_options, :image_options, :header_options, :body_options

  # image_options: {src:, alt:, url:, default:}
  def initialize(card_options: {}, image_options: {}, header_options: {}, body_options: {})
    @card_options = card_options
    @image_options = image_options
    @header_options = header_options
    @body_options = body_options
  end

  renders_one :header
  renders_one :body

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
