module Organizations
  module AdopterFosterer
    class AdoptedPetsController < Organizations::BaseController

      layout "adopter_foster_dashboard"

      def index
        authorize! with: Organizations::AdopterFosterAdoptedPetPolicy

      end
    end
  end
end
