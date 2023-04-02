class SuccessesController < ApplicationController

  # create array of location objects and tweak duplicate locations to be unique
  def index
    @raw_collection = create_collection_of_adoption_data
    @duplicate_locations = find_duplicate_locations

    if @duplicate_locations.empty?
      @map_collection = @raw_collection
    else
      @map_collection = modify_duplicate_locations
    end
  end

  private

  #relocate this logic to a PORO and use in #index
  def create_collection_of_adoption_data
    collection = []
    Adoption.all.each do |record|
      unless record.adopter_account.adopter_profile.location.latitude.nil?
        adoption_data = {
          latitude: record.adopter_account.adopter_profile.location.latitude,
          longitude: record.adopter_account.adopter_profile.location.longitude,
        }
      end
      collection << adoption_data if adoption_data
    end
    collection
  end

  def find_duplicate_locations
    @raw_collection.group_by {|e| e}.select {|k,v| v.size > 1}.map(&:first)
  end

  def modify_duplicate_locations
    modified_collection = @raw_collection
    @duplicate_locations.each do |location|
      count = @raw_collection.count(location)
      locations_to_modify = Array.new(count - 1, location)
      locations_to_modify.each {|l| l[:longitude] = l[:longitude] + rand(0.9)}
      modified_collection << locations_to_modify
    end
    modified_collection.flatten.uniq
  end
end
