class ChecklistTemplateItemsController < Organizations::BaseController
  private

  def checklist_template_item_params
    params.require(:checklist_template_item).permit(:checklist_template_id, :name, :description, :expected_duration_days, :required)
  end
end
