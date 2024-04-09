# Controller to permit roles admin & staff to see user profiles
class Organizations::ProfileReviewsController < Organizations::BaseController
  def show
    @adopter_foster_profile = AdopterFosterProfile.find(params[:id])

    authorize! @adopter_foster_profile, with: Organizations::ProfileReviewPolicy
  end
end
