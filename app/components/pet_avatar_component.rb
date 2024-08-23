# frozen_string_literal: true

# Renders a Pet's image and the Heart like button
class PetAvatarComponent < ApplicationComponent
  param :pet, Types::Instance(Pet)
  option :like, optional: true

  private

  def pet_avatar
    pet_image || pet_initials_span
  end

  def pet_image
    if pet.images.present? && pet.images.first.present?
      image_tag(url_for(pet.images.first), alt: pet.name, class: image_class)
    end
  end

  def pet_initials_span
    if pet.name.present?
      content_tag(:span, pet_initials, class: initials_class)
    end
  end

  def pet_initials
    pet.name[0].upcase
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
