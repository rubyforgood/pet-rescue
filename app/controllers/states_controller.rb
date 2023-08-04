class StatesController < ApplicationController
  def index
    @target = params[:target]
    @name = params[:name]
    @states = CS.states(params[:country]).invert
  end
end
