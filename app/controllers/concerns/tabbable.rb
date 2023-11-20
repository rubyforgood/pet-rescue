module Tabbable 
  extend ActiveSupport::Concern

  def determine_active_tab 
    ["tasks", "applications", "files"].include?(params[:active_tab]) ? params[:active_tab] : "overview"
  end
end