class ChecklistTemplateItemsController < Organizations::BaseController
  def index
    @checklist_template_items = ChecklistTemplateItem.all
  end

  def show
    @checklist_template_item = ChecklistTemplateItem.find(params[:id])
  end

  private

  def checklist_template_item_params
    params.require(:checklist_template_item).permit(:checklist_template_id, :name, :description, :expected_duration_days, :required)
  end
end
