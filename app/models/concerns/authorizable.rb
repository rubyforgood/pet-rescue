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

  ADOPTER_PERMISSIONS = %i[].freeze

  STAFF_PERMISSIONS = (
    ADOPTER_PERMISSIONS + %i[
      manage_pets
      manage_tasks
    ]
  ).freeze

  ADMIN_PERMISSIONS = (
    STAFF_PERMISSIONS + %i[
      activate_staff
      invite_staff
      manage_staff
    ]
  ).freeze

  PERMISSIONS = {
    adopter: ADOPTER_PERMISSIONS,
    staff: STAFF_PERMISSIONS,
    admin: ADMIN_PERMISSIONS
  }.freeze
end
