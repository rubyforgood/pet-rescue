module Organizations
  module Staff
    module Checklist
      class TaskTemplatesController < Organizations::BaseController
        before_action :context_authorize!, only: %i[index new create]
        before_action :set_task, only: %i[edit update destroy]

        layout "dashboard"

        def index
          @task_templates = authorized_scope(TaskTemplate.all)
        end

        def new
          @task_template = TaskTemplate.new
        end

        def create
          @task_template = TaskTemplate.new(task_params)

          if @task_template
            redirect_to staff_task_templates_path, notice: t(".success")
          else
            flash.now[:alert] = t(".error")
            render :new, status: :unprocessable_entity
          end
        end

        def edit
        end

        def update
          if @task_template.update(task_params)
            redirect_to staff_task_templates_path, notice: t(".success")
          else
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @task_template.destroy

          redirect_to staff_task_templates_path, notice: t(".success")
        end

        private

        def task_params
          params.require(:task_template).permit(:name, :description, :due_in_days, :recurring)
        end

        def set_task
          @task_template = TaskTemplate.find(params[:id])

          authorize! @task_template
        rescue ActiveRecord::RecordNotFound
          redirect_to staff_task_templates_path, alert: t(".error")
        end

        def context_authorize!
          authorize! TaskTemplate,
            context: {organization: Current.organization}
        end
      end
    end
  end
end
