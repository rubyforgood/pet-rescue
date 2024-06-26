# frozen_string_literal: true

# Renders a User's avatar as image or user's initials
class AvatarComponent < ApplicationComponent
  VALID_SIZES = %i[md xl].freeze

  attr_reader :user, :size

  # @param user [User] user of the avatar
  # @param size [Symbol] size option, `:md` or `:xl`
  def initialize(user:, size: :md)
    @user = user
    @size = filter_attribute(size, VALID_SIZES, default: :md)
  end

  private

  def avatar
    if image_url
      image_tag(url_for(image_url), alt: alt, class: image_classes)
    else
      content_tag(:span, initials, class: initials_classes)
    end
  end

  def image_url
    @user.avatar.attached? ? url_for(@user.avatar) : nil
  end

  def initials
    "#{user.first_name[0]}#{user.last_name[0]}".upcase
  end

  def alt
    "#{user.first_name.capitalize}'s avatar"
  end

  def container_classes
    case size
    when :md
      "avatar avatar-md avatar-primary"
    when :xl
      "avatar avatar-xl avatar-primary rounded-circle border border-4 border-white"
    end
  end

  def image_classes
    "rounded-circle"
  end

  def initials_classes
    case size
    when :md
      "avatar-initials rounded-circle"
    when :xl
      "avatar-initials rounded-circle fs-2"
    end
  end
end
