# frozen_string_literal: true

# Use Avatar::Component to represent users with image or initials.
class AvatarComponent < ViewComponent::Base
  SIZES = {
    x_small: "avatar-xs",
    small: "avatar-sm",
    medium: "avatar-md",
    large: "avatar-lg",
    x_large: "avatar-xl",
    xx_large: "avatar-xxl"
  }.freeze

  #
  # @example 1|Show avatar with initials
  # <%= component "avatar", alt: "JT" %>
  #
  # @example 2|Show avatar with image_tag
  # <%= component "avatar", src: "avatar_#{@order.subject.gender}.svg",
  #                         size: :medium) %>
  #
  # @example 2|Show avatar with image_tag with default params
  # <%= component "avatar", src: "avatar_#{@order.subject.gender}.svg"%>
  #
  # @param src [String] Specifies the URL of the image.
  # @param alt[String] Alternate text for an image, if the image cannot be displayed.

  def initialize(alt: "avatar", size: :medium, **system_arguments)
    @alt = alt
    @system_arguments = system_arguments
    @classes = "rounded-circle cursor-pointer avatar #{SIZES.fetch(size)}"
  end

  def avatar_with_image
    image_tag @system_arguments[:src], class: @classes, alt: @alt
  end

  def avatar_with_initials
    tag.div(tag.span(@alt), class: @classes, style: "background-color: #{avatar_color(@alt)}; display: flex; align-items: center; justify-content: center;")
  end

  def avatar_color(text)
    avatar_colors = ["#feb2b2", "#b3e4fc", "#d6bcfa", "#faf089", "#9ae6b4", "#f0e2ba", "#fbb6ce", "#dadada"]

    avatar_colors[text.ord % avatar_colors.length]
  end

  def call
    if @system_arguments[:src].present?
      avatar_with_image
    else
      avatar_with_initials
    end
  end
end
