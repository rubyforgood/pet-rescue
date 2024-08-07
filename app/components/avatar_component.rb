# frozen_string_literal: true

# Renders a User's avatar as image or user's initials
class AvatarComponent < ApplicationComponent
  option :pet, Types::Instance(Pet), optional: true
  option :like, optional: true
  option :size, Types::Size, default: -> { :md }

  private

  def avatar
    if pet
      image_tag(url_for(pet.images.first), alt: pet.name, class: image_classes)
    else
      content_tag(:span, pet_initials, class: initials_classes)
    end
  end

  def pet_initials
    "pet"
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
