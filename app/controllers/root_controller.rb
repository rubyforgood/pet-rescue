class RootController < ApplicationController
  skip_before_action :authenticate_user!
  skip_verify_authorized only: %i[index]

  def index
    if Current.organization
      redirect_to home_index_path
    end
  end
end
