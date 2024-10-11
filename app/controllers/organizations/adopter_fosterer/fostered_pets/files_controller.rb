module Organizations
  module AdopterFosterer
    module FosteredPets
      class FilesController < Organizations::BaseController
        skip_verify_authorized only: %i[index]

        def index
          @pet = Pet.find(params[:fostered_pet_id])
        end
      end
    end
  end
end
