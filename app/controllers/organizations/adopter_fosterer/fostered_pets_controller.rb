module Organizations
  module AdopterFosterer
    class FosteredPetsController < Organizations::BaseController
      before_action :context_authorize!
      layout "adopter_foster_dashboard"

      def index
        @fostered_pets = authorized_scope(Match.fosters, with: Organizations::AdopterFosterer::MatchPolicy)
      end

      private

      def context_authorize!
        authorize! with: Organizations::AdopterFosterer::MatchPolicy
      end
    end
  end
end
