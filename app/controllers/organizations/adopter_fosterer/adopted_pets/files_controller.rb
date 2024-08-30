module Organizations
  module AdopterFosterer
    module AdoptedPets
      class FilesController < Organizations::BaseController
        skip_verify_authorized only: %i[index]

        def index
          @pet = Pet.find(params[:adopted_pet_id])
          respond_to do |format|
            format.html # Regular HTML response
            format.turbo_stream do
              render turbo_stream: turbo_stream.replace(
                "pet_files",
                partial: "organizations/shared/file_attachment_table",
                locals: {pet: @pet}
              )
            end
          end
        end
      end
    end
  end
end