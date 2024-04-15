class Organizations::PageTextsController < Organizations::BaseController
  layout "dashboard"
  before_action :set_page_text, only: %i[edit update]
  def edit
  end

  def update
    if image_too_large?(page_text_params[:hero_image])
      redirect_to edit_page_text_path, alert: "Image is too large."
    elsif @page_text.update(page_text_params)
      redirect_to edit_page_text_path, notice: "Page text updated successfully!"
    else
      redirect_to edit_page_text_path
    end
  end

  private

  def image_too_large?(uploaded_image)
    uploaded_image.size > 2.megabytes
  end

  def page_text_params
    params.require(:page_text).permit(:hero, :about, :hero_image, about_us_images: [])
  end

  def set_page_text
    @page_text = current_user.organization.page_text

    authorize! @page_text
  end
end
