module Organizations
  module AdopterFosterer
    class ExternalFormController < ApplicationController
      skip_verify_authorized # MARK: what should the auth policy look like for this action?
      layout :form_layout

      def index
        @form_url = Current.organization.external_form_url
      end

      private
      def form_layout
        if params[:dashboard]
          "adopter_foster_dashboard"
        else
          "application"
        end
      end
    end
  end
end
