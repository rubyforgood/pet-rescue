module Organizations
  module AdopterFosterer
    class FormSubmissionsController < ApplicationController
      def create
        authorize! with: FormSubmissionPolicy

        if current_user.form_submission.blank?
          FormSubmission.create!(person_id: current_user.person_id, organization_id: current_user.organization_id)
        end

        redirect_to adoptable_pets_path
      end
    end
  end
end
