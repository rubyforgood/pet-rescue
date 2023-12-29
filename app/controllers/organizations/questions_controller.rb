class Organizations::QuestionsController < Organizations::BaseController
  before_action :verified_staff

  def new
    @organization = current_user.organization
    @form = @organization.form || Form.create(organization: @organization, name: "#{@organization.name}'s Application Form")
    @question = @form.questions.build
  end

  def create
    @organization = current_user.organization
    @form = @organization.form
    @question = Question.new(question_params)

    if @question.save && FormQuestion.create(question: @question, form: @form)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("questions_list", partial: "organizations/forms/form", locals: {question: @question}) }
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :input_type)
  end
end
