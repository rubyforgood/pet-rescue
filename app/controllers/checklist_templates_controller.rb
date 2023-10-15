class ChecklistTemplatesController < Organizations::BaseController
  def index
    @checklist_templates = ChecklistTemplate.all
  end

  def show
    @checklist_template = ChecklistTemplate.find(params[:id])
  end

  private

  def checklist_template_params
    params.require(:checklist_template).permit(:name, :description)
  end
end
