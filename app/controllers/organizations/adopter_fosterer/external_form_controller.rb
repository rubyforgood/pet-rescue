module Organizations
  module AdopterFosterer
    class ExternalFormController < ApplicationController
      skip_verify_authorized # MARK: what should the auth policy look like for this action?

      def index
      end
    end
  end
end

# TODO: need stimulus controller to make request to create empty form submission for current_user