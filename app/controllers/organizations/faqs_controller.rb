class Organizations::FaqsController < Organizations::BaseController
  before_action :set_faq, only: %i[show edit update destroy]

  # GET /organizations/faqs or /organizations/faqs.json
  def index
    @faqs = Faq.all
  end

  # GET /organizations/faqs/1 or /organizations/faqs/1.json
  def show
  end

  # GET /organizations/faqs/new
  def new
    @faq = Faq.new
  end

  # GET /organizations/faqs/1/edit
  def edit
  end

  # POST /organizations/faqs or /organizations/faqs.json
  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to faq_url(@faq), notice: "Faq was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/faqs/1 or /organizations/faqs/1.json
  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to faq_url(@faq), notice: "Faq was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/faqs/1 or /organizations/faqs/1.json
  def destroy
    @faq.destroy!

    respond_to do |format|
      format.html { redirect_to faqs_url, notice: "Faq was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_faq
    @faq = Faq.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def faq_params
    params.require(:faq).permit(:question, :answer, :order)
  end
end
