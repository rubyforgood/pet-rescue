module Organizations
  module AdopterFosterer
    class AdoptedPetsController < Organizations::BaseController

      layout "adopter_foster_dashboard"

      def index
        authorize! with: Organizations::AdopterFosterAdoptedPetPolicy

        @adopted_pets = authorized_scope(AdopterApplication.joins(:pet)
        .where(status: :adoption_made, profile_show: true)
        .select('pets.*'), with: Organizations::AdopterFosterAdoptedPetPolicy)
      end
    end
  end
end
