# frozen_string_literal: true

# Renders a User's avatar as image or user's initials
class PetAvatarComponent < ApplicationComponent
  option :pet, Types::Instance(Pet), optional: true
  option :like, optional: true

  private

  def pet_avatar
    if pet
      image_tag(url_for(pet.images.first), alt: pet.name, class: image_class)
    else
      content_tag(:span, initials, class: initials_class)
    end
  end

  def initials
    if pet
      pet.name[0].upcase
    end
  end

  def image_class
    "rounded-circle"
  end

  def initials_class
    "avatar-initials rounded-circle fs-2"
  end

  def container_class
    "avatar avatar-xl avatar-primary rounded-circle border border-4 border-white"
  end
end
