module Organizations
  module AdopterFosterer
    class MatchPolicy < ApplicationPolicy
      relation_scope do |relation|
        relation.where(person_id: user.person.id)
      end

      def index?
        permission?(:view_adopted_pets)
      end
    end
  end
end
