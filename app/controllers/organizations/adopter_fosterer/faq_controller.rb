module Organizations
  module AdopterFosterer
    class FaqController < Organizations::BaseController
      skip_verify_authorized only: [:index]
      layout "adopter_foster_dashboard", only: :index

      def index
        @faqs = Faq.all
      end
    end
  end
end
