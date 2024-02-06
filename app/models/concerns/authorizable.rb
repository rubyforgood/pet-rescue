ADOPTER_PERMISSIONS = %i[].freeze

STAFF_PERMISSIONS = (
  ADOPTER_PERMISSIONS + %i[
    manage_pets
  ]
).freeze

ADMIN_PERMISSIONS = (
  STAFF_PERMISSIONS + %i[
    activate_staff
    manage_staff
  ]
).freeze

PERMISSIONS = {
  adopter: ADOPTER_PERMISSIONS,
  staff: STAFF_PERMISSIONS,
  admin: ADMIN_PERMISSIONS
}.freeze

module Authorizable
  extend ActiveSupport::Concern

  included do
    rolify
  end

  def permission?(name)
    roles.any? do |role|
      PERMISSIONS.fetch(role.name.to_sym).include?(name)
    end
  end
end
