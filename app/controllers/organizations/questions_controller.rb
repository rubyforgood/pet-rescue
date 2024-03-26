# frozen_string_literal: true

module Organizations
  class QuestionsController < ApplicationController
    before_action :context_authorize!
    before_action :set_form
    before_action :set_question, only: %i[show edit update destroy]

    layout 'dashboard'

    def index
      @questions = authorized_scope(@form.questions)
    end

    def new
      @question = @form.questions.new
    end

    def create
      @question = @form.questions.new(question_params)

      if @question.save
        redirect_to form_path(@form), notice: t('.saved')
      else
        flash.now[:alert] = t('.error')

        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to form_path(@form), notice: t('.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @question.destroy

      redirect_to form_path(@form), notice: t('.destroyed')
    end

    private

    def organization
      current_user.organization
    end

    def set_form
      @form = organization.forms.find(params[:form_id])
      authorize! @form
    rescue ActiveRecord::RecordNotFound
      redirect_to forms_path, alert: t('.form_not_found')
    end

    def set_question
      @question = @form.questions.find(params[:id])
      authorize! @question
    rescue ActiveRecord::RecordNotFound
      redirect_to form_path(@form), alert: t('.not_found')
    end

    def question_params
      params.require(:question).permit(:name, :description, :label, :help_text, :required, :input_type, :options)
    end

    def context_authorize!
      authorize! Question, context: { organization: Current.organization }
    end
  end
end
