module Organizations
  module Checklist
    class TaskTemplatePolicy < ApplicationPolicy
      pre_check :verify_organization!
      pre_check :verify_active_staff!

      alias_rule :new?, :create?, :index?, to: :manage?

      def manage?
        permission?(:manage_task_templates)
      end
    end
  end
end
