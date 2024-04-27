class Organizations::FormsController < ApplicationController
  before_action :context_authorize!
  before_action :set_form, only: %i[show edit update destroy]

  layout "dashboard"

  def index
    @forms = authorized_scope(Form.all)
  end

  def new
    @form = Form.new
  end

  def create
    @form = organization.forms.new(form_params)

    if @form.save
      redirect_to forms_path, notice: t(".saved")
    else
      flash.now[:alert] = t(".error")

      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @form.update(form_params)
      redirect_to forms_path, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @form.destroy

    redirect_to forms_path, notice: t(".destroyed")
  end

  private

  def organization
    current_user.organization
  end

  def set_form
    @form = organization.forms.find(params[:id])
    authorize! @form
  rescue ActiveRecord::RecordNotFound
    redirect_to forms_path, alert: t(".not_found")
  end

  def form_params
    params.require(:form).permit(:name, :description, :title, :instructions)
  end

  def context_authorize!
    authorize! Form, context: {organization: Current.organization}
  end
end
