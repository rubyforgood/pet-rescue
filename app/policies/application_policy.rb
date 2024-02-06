# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  # Read more about authorization context: https://actionpolicy.evilmartians.io/#/authorization_context

  pre_check :verify_authenticated!

  authorize :user, allow_nil: true

  relation_scope do |relation|
    relation.where(organization: user.organization)
  end

  private

  # Define shared methods useful for most policies.

  def verify_organization!
    deny! unless record.organization == user.organization
  end

  def permission?(name)
    return false unless user

    user.permission?(name)
  end

  def authenticated? = user.present?

  def unauthenticated? = !authenticated?

  def verify_authenticated!
    deny! if unauthenticated?
  end
end
