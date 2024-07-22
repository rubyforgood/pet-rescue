module Organizations
  module AdopterFosterer
    class DonationsController < Organizations::BaseController
      skip_verify_authorized only: [:index]
      layout "adopter_foster_dashboard", only: :index

      def index; end
    end
  end
end
