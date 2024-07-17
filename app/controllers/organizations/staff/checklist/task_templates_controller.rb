module Organizations
  module Staff
    module Checklist
      class TaskTemplatesController < Organizations::BaseController
        before_action :context_authorize!, only: %i[index new create]
        before_action :set_task, only: %i[edit update destroy]

        layout "dashboard"

        def index
          @task_templates = authorized_scope(Organizations::Staff::Checklist::TaskTemplate.all)
        end

        def new
          @task = TaskTemplate.new
        end

        def create
          @task = TaskTemplate.new(task_params)

          if @task.save
            redirect_to staff_checklist_task_templates_path, notice: t(".success")
          else
            flash.now[:alert] = t(".error")
            render :new, status: :unprocessable_entity
          end
        end

        def edit
          binding.pry
        end

        def update

          if @task.update(task_params)
            binding.pry
            redirect_to staff_checklist_task_templates_path, notice: t(".success")
          else
            binding.pry
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          # binding.pry
          @task.destroy

          redirect_to staff_checklist_task_templates_path, notice: t(".success")
        end

        private

        def task_params
          params.require(:task_template).permit(:name, :description, :due_in_days, :recurring)
        end

        def set_task
          # binding.pry
          @task = TaskTemplate.find(params[:id])

          authorize! @task
        rescue ActiveRecord::RecordNotFound
          redirect_to staff_checklist_task_templates_path, alert: t(".error")
        end

        def context_authorize!
          authorize! TaskTemplate,
            context: {organization: Current.organization}
        end
      end
    end
  end
end
