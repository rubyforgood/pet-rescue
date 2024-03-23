class Organizations::PageTextsController < Organizations::BaseController
  layout "dashboard"
  def edit
    @page_text = current_user.organization.page_text
  end

  def update
    @page_text = current_user.organization.page_text
    if @page_text.update(page_text_params)
      redirect_to edit_page_text_path, notice: "Page text updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def page_text_params
    params.require(:page_text).permit(:hero, :about)
  end
end
