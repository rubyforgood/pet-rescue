class DeactivateToggleComponent < ViewComponent::Base
  attr_reader :account, :role

  def initialize(account:, role:)
    @account = account
    @role = role
  end
end
