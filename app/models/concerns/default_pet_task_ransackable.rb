module DefaultPetTaskRansackable
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_tasks(tasks, params)
      tasks = apply_species_filter(tasks, params)
      tasks = apply_recurring_filter(tasks, params)
      tasks = apply_due_in_days_filter(tasks, params)

      tasks.ransack(params[:q])
    end

    private

    def apply_species_filter(tasks, params)
      if params[:q].present? && params[:q]["species_eq"].present?
        species_filter = params[:q]["species_eq"]
        params[:q]["species_eq"] = Pet.species[species_filter] if Pet.species.key?(species_filter)
      end
      tasks
    end

    def apply_recurring_filter(tasks, params)
      if params[:q].present? && params[:q]["recurring"].present?
        if params[:q]["recurring"] == "true"
          tasks = tasks.where(recurring: true)
        elsif params[:q]["recurring"] == "false"
          tasks = tasks.where(recurring: false)
        end
      end
      tasks
    end

    def apply_due_in_days_filter(tasks, params)
      if params[:q].present? && params[:q]["due_in_days"].present?
        tasks = tasks.where("due_in_days = ?", params[:q]["due_in_days"].to_i)
      end
      tasks
    end
  end
end
