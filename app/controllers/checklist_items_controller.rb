class ChecklistItemsController < Organizations::BaseController
  def index
    @checklist_items = ChecklistItem.all
  end

  def show
    @checklist_item = ChecklistItem.find(params[:id])
  end

  private

  def checklist_item_params
    params.require(:checklist_item).permit(:name, :description, :input_type)
  end
end
