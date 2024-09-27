module Organizations
  module AdopterFosterer
    module AdoptedPets
      class FilesController < Organizations::BaseController
        skip_verify_authorized only: %i[index]

        def index
          @pet = Pet.find(params[:adopted_pet_id])
          respond_to do |format|
            format.html
          end
        end
      end
    end
  end
end
