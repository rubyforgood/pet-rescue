module Organizations
  module Staff
    class ExternalFormSubmissionController < Organizations::BaseController
      layout "dashboard"

      def index
        authorize! StaffAccount, context: {organization: Current.organization}
      end
    end
  end
end
