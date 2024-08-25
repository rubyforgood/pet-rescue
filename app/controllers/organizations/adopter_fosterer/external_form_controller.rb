module Organizations
  module AdopterFosterer
    class ExternalFormController < ApplicationController
      skip_verify_authorized # MARK: what should the auth policy look like for this action?

      def index
        @form_url = Current.organization.external_form_url
      end
    end
  end
end
