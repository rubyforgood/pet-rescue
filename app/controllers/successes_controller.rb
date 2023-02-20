class SuccessesController < ApplicationController

  def index
    @adoption_all = Adoption.all
  end

end
