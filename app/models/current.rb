# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  # Set attributes to be available in the entire stack
  attribute :tenant, :user

end
