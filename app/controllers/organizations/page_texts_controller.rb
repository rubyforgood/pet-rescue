class Organizations::PageTextsController < Organizations::BaseController
  def edit
    @page_text = Current.organization.page_text
  end

  def update
    @page_text = Current.organization.page_text
    if @page_text.update(page_text_params)
      redirect_to dashboard_path, notice: "Page text updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def page_text_params
    params.require(:page_text).permit(:hero, :about)
  end
end
