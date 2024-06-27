require "dry-initializer"
require "dry-types"

class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer

  module Types
    include Dry.Types()

    # Custom types
    ImageTagSource =
      Types::String |
      Types::Symbol |
      Types::Nil |
      Types::Instance(ActiveStorage::Attachment) |
      Types::Instance(ActiveStorage::Attached::One) |
      Types::Instance(ActiveStorage::Attached::Many)
  end

  def filter_attribute(value, allowed_values, default: nil)
    return default unless value
    return value if allowed_values.include?(value)

    default
  end
end
