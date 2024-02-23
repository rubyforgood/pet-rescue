module Authorizable
  extend ActiveSupport::Concern

  included do
    rolify
  end

  def permission?(name)
    permissions.include?(name)
  end

  private

  def permissions
    roles.reduce([]) do |permissions, role|
      permissions.concat(PERMISSIONS.fetch(role.name.to_sym))
    end
  end

  ADOPTER_PERMISSIONS = %i[
    create_adopter_applications
    view_adopter_applications
    withdraw_adopter_applications
  ].freeze

  STAFF_PERMISSIONS = (
    ADOPTER_PERMISSIONS + %i[
      manage_pets
      manage_tasks
      view_organization_dashboard
    ]
  ).freeze

  ADMIN_PERMISSIONS = (
    STAFF_PERMISSIONS + %i[
      activate_staff
      invite_staff
      manage_organization_profile
      manage_staff
    ]
  ).freeze

  PERMISSIONS = {
    adopter: ADOPTER_PERMISSIONS,
    staff: STAFF_PERMISSIONS,
    admin: ADMIN_PERMISSIONS
  }.freeze
end
