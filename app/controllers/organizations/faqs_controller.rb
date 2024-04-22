class Organizations::FaqsController < Organizations::BaseController
  layout "dashboard"
  before_action :context_authorize!
  before_action :set_faq, only: %i[show edit update destroy]

  def index
    @faqs = authorized_scope(Faq.all)
  end

  def show
  end

  def new
    @faq = Faq.new
  end

  def edit
  end

  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to faqs_url, notice: "FAQ was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to faqs_url, notice: "FAQ was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faq.destroy!

    respond_to do |format|
      format.html { redirect_to faqs_url, notice: "FAQ was successfully deleted." }
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
