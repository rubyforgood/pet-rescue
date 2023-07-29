class ChecklistTemplatesController < InheritedResources::Base

  private

    def checklist_template_params
      params.require(:checklist_template).permit(:name, :description)
    end

end
