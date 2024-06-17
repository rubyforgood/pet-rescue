# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  VALID_SIZES = %i[md xl].freeze

  attr_reader :user, :size

  def initialize(user:, size: :md)
    @user = user
    @size = filter_attribute(size, VALID_SIZES, default: :md)
  end

  def filter_attribute(value, allowed_values, default: nil)
    return default unless value
    return value if allowed_values.include?(value)

    default
  end

  private

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
