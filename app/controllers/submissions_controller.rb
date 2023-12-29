class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @form = Current.organization.form
    @submission = Submission.new(form: @form)
  end

  def create
    @submission = Submission.new(form: Current.organization.form, user: current_user)
    responses = []
    submission_params.each do |question_id, response|
      responses << Response.new(
        question_id: question_id,
        string_value: response,
        submission: @submission
      )
    end

    ActiveRecord::Base.transaction do
      responses.each do |response|
        unless response.save
          debugger
        end
      end
    end

    redirect_to adoptable_pets_path, notice: "Application form successfully submitted."
  end

  private

  def submission_params
    params.require(:submission)
  end
end
