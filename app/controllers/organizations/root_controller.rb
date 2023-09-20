class Organizations::HomeController < ApplicationController
  layout "no_tenant"

  def index
    if Current.organization
      redirect_to root_path
    elsif user_signed_in?
      redirect_to root_path
    end
  end

end
