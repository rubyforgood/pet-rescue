class Organizations::FaqsController < Organizations::BaseController
  layout "dashboard"
  before_action :context_authorize!, only: %i[index new create]
  before_action :set_faq, only: %i[show edit update destroy]

  def index
    @faqs = authorized_scope(Faq.all)
  end

  def new
    @faq = Faq.new
  end

  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @faq = Faq.new(faq_params)

    if @faq.save
      redirect_to faqs_url, notice: "FAQ was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to faqs_url, notice: "FAQ was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faq.destroy!
    respond_to do |format|
      format.html { redirect_to faqs_url, notice: "FAQ was successfully deleted." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@faq) }
    end
  end

  private

  def set_faq
    @faq = Faq.find(params[:id])

    authorize! @faq
  rescue ActiveRecord::RecordNotFound
    redirect_to faqs_path, alert: "FAQ not found."
  end

  def faq_params
    params.require(:faq).permit(:question, :answer, :order)
  end

  def context_authorize!
    authorize! Faq,
      context: {organization: Current.organization}
  end
end
