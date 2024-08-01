module Authorizable
  extend ActiveSupport::Concern

  included do
    rolify
  end

  def permission?(name)
    permissions.include?(name)
  end

  ADOPTER_PERMISSIONS = %i[
    view_adopter_foster_dashboard
    create_adopter_applications
    view_adopter_applications
    withdraw_adopter_applications
    create_adopter_foster_profiles
    manage_adopter_foster_profiles
    purge_avatar
    manage_likes
    view_adopted_pets
  ].freeze

  FOSTERER_PERMISSIONS = %i[
    view_adopter_foster_dashboard
    create_adopter_foster_profiles
    manage_adopter_foster_profiles
    purge_avatar
  ].freeze

  ADMIN_PERMISSIONS = (
    ADOPTER_PERMISSIONS.excluding(
      %i[
        view_adopter_foster_dashboard
        create_adopter_applications
        create_adopter_foster_profiles
        manage_adopter_foster_profiles
        manage_likes
      ]
    ) + %i[
      review_adopter_applications
      view_adopter_foster_accounts
      view_adopter_foster_profiles
      invite_fosterers
      purge_attachments
      manage_default_pet_tasks
      manage_forms
      manage_questions
      manage_matches
      manage_pets
      manage_tasks
      view_organization_dashboard
      manage_faqs
    ]
  ).freeze

  SUPER_ADMIN_PERMISSIONS = (
    ADMIN_PERMISSIONS + %i[
      activate_staff
      invite_staff
      manage_organization
      manage_custom_page
      manage_staff
      change_user_roles
    ]
  ).freeze

  PERMISSIONS = {
    adopter: ADOPTER_PERMISSIONS,
    fosterer: FOSTERER_PERMISSIONS,
    admin: ADMIN_PERMISSIONS,
    super_admin: SUPER_ADMIN_PERMISSIONS
  }.freeze

  private

  def permissions
    roles.reduce([]) do |permissions, role|
      permissions.concat(PERMISSIONS.fetch(role.name.to_sym))
    end
  end
end
