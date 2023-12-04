# frozen_string_literal: true

module Organizations
  class PetsController < Organizations::BaseController
    before_action :set_pet, only: %i[show edit update destroy]
    before_action :verified_staff
    before_action :set_nav_tabs, only: [:show]

    after_action :set_reason_paused_to_none, only: [:update]
    layout 'dashboard'

    def index
      @q = Pet.ransack(params[:q])
      @pets = @q.result
    end

    def new
      @pet = Pet.new
    end

    def edit
      return if pet_in_same_organization?(@pet.organization_id)

      redirect_to pets_path, alert: 'This pet is not in your organization.'
    end

    def show
      @active_tab = determine_active_tab
      @pause_reason = @pet.pause_reason
      return if pet_in_same_organization?(@pet.organization_id)

      redirect_to pets_path, alert: 'This pet is not in your organization.'
    end

    def create
      @pet = Pet.new(pet_params)

      if @pet.save
        redirect_to pets_path, notice: 'Pet saved successfully.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if pet_in_same_organization?(@pet.organization_id) && @pet.update(pet_params)
        redirect_to @pet, notice: 'Pet updated successfully.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @pet = Pet.find(params[:id])

      if pet_in_same_organization?(@pet.organization_id) && @pet.destroy
        redirect_to pets_path, notice: 'Pet deleted.', status: :see_other
      else
        redirect_to pets_path, alert: 'Error.'
      end
    end

    private

    def pet_params
      params.require(:pet).permit(
        :application_paused,
        :birth_date,
        :breed,
        :description,
        :is_published,
        :name,
        :organization_id,
        :pause_reason,
        :placement_type,
        :sex,
        :species,
        :weight_from,
        :weight_to,
        :weight_unit,
        append_images: []
      )
    end

    def set_pet
      @pet = Pet.find(params[:id])
    end

    # update Pet pause_reason to not paused if applications resumed
    def set_reason_paused_to_none
      return unless @pet.application_paused == false

      @pet.pause_reason = 0
      @pet.save!
    end

    def set_nav_tabs
      @nav_tabs = [
        { name: 'Summary', path: pet_path(@pet) }
      ]
    end

    def determine_active_tab
      %w[tasks applications files].include?(params[:active_tab]) ? params[:active_tab] : 'overview'
    end
  end
end
