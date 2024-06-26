# frozen_string_literal: true

# Renders a card component
class CardComponent < ApplicationComponent
  option :card_options,
    Types::Hash.schema(
      class?: Types::String
    ),
    default: proc { {} }

  option :header_options,
    Types::Hash.schema(
      class?: Types::String
    ),
    default: proc { {} }

  option :body_options,
    Types::Hash.schema(
      class?: Types::String
    ),
    default: proc { {} }

  option :image_options,
    Types::Hash.schema(
      src?: Types::Nominal::Any,
      class?: Types::String,
      url?: Types::String,
      default?: Types::String
    ),
    default: proc { {} }

  renders_one :header
  renders_one :body
  renders_one :badge

  private

  def card_class
    @card_class ||= card_options[:class] || "card card-hover"
  end

  def header_class
    @header_class ||= header_options[:class] || "card-header"
  end

  def body_class
    @body_class ||= body_options[:class] || "card-body"
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

  def image_default
    @image_default ||= image_options[:default] || "coming_soon.jpg"
  end
end
