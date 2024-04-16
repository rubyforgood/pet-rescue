class Organizations::PageTextsController < Organizations::BaseController
  layout "dashboard"
  before_action :set_page_text, only: %i[edit update]
  def edit
  end

  def update
    if @page_text.update(page_text_params)
      redirect_to edit_page_text_path, notice: "Page text updated successfully!"
    else
      redirect_to edit_page_text_path, alert: @page_text.errors.full_messages.to_sentence
    end
  end

  private

  def page_text_params
    params.require(:page_text).permit(:hero, :about, :hero_image, about_us_images: [])
  end

  def set_page_text
    @page_text = current_user.organization.page_text

    authorize! @page_text
  end
end
