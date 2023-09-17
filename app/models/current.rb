# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  # Set attributes to be available in the entire stack
  attribute :organization, :user
  alias tenant organization

end
