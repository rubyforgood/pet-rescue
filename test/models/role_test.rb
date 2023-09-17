# frozen_string_literal: true

require "test_helper"

class RoleTest < ActiveSupport::TestCase
  context 'associations' do
    should have_and_belong_to_many(:staff_accounts).join_table(:staff_accounts_roles)
    should belong_to(:resource).optional
  end

  context 'validations' do
    should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types).allow_nil
  end
end
