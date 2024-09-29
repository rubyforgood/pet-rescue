module Organizations
  module AdopterFosterer
    module AdoptedPets
      class FilesController < Organizations::BaseController
        skip_verify_authorized only: %i[index]

        def index
          @pet = Pet.find(params[:adopted_pet_id])
        end
      end
    end
  end
end
