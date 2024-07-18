class DeactivateToggleComponent < ViewComponent::Base
  attr_reader :account, :role, :current_user

  def initialize(account:, role:, current_user:)
    @account = account
    @role = role
    @current_user = current_user
  end
end
