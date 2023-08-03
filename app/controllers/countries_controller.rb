class CountriesController < ApplicationController
  def states
    @target = params[:target]
    @name = params[:name]
    @states = CS.states(params[:country]).invert
  end
end
