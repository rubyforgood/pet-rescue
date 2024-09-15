module Organizations
  module AdopterFosterer
    class ExternalFormController < ApplicationController
      skip_verify_authorized # MARK: what should the auth policy look like for this action?

      before_action :form_instructions
      
      layout :form_layout

      def index
        @form_url = Current.organization.external_form_url
      end

      private

      def form_layout
        return "adopter_foster_dashboard" if params[:dashboard]
          
        "application"
      end

      def form_instructions
        if params[:dashboard]
          @form_instructions = t('organizations.adopter_fosterer.form_instructions.dashboard')
        else
          @form_instructions = t('organizations.adopter_fosterer.form_instructions.index', organization_name: Current.tenant.name)
        end
      end
    end
  end
end
