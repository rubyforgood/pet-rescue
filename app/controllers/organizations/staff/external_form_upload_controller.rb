module Organizations
  module Staff
    class ExternalFormUploadController < Organizations::BaseController
      layout "dashboard"

      def index
        authorize! :external_form_upload,
          context: {organization: Current.organization}
      end
    end
  end
end
