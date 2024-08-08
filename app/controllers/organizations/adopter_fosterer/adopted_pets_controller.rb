module Organizations
  module AdopterFosterer
    class AdoptedPetsController < Organizations::BaseController
      before_action :context_authorize!
      layout "adopter_foster_dashboard"

      def index
        @adopted_pets = authorized_scope(AdopterApplication.joins(:pet)
        .where(status: :adoption_made, profile_show: true), with: Organizations::AdopterFosterAdoptedPetPolicy)
      end

      def files
        @pet = Pet.find(params[:id])
        respond_to do |format|
          format.html # Regular HTML response
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "pet_files",
              partial: "pet_files",
              locals: {pet: @pet}
            )
          end
        end
      end

      private

      def context_authorize!
        authorize! with: Organizations::AdopterFosterAdoptedPetPolicy
      end
    end
  end
end
