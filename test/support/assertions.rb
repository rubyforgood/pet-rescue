require "minitest/assertions"

module PetRescue
  module PolicyAssertions
    def assert_alias_rule(policy, actual, rule)
      assert_equal policy.resolve_rule(actual), rule
    end
  end
end
