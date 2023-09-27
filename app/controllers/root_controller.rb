class RootController < ApplicationController
  def index
    if Current.organization
      redirect_to home_index_path
    end
  end
end
