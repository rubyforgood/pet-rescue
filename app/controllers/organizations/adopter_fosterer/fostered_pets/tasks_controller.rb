module Organizations
  module AdopterFosterer
    module FosteredPets
      class TasksController < Organizations::BaseController
        before_action :context_authorize!

        def index
          @pet = Pet.find(params[:fostered_pet_id])
          @tasks = @pet.tasks.is_not_completed
        end

        private

        def context_authorize!
          authorize! with: Organizations::AdopterFosterer::TaskPolicy
        end
      end
    end
  end
end
