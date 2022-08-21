class Adoption < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account

  def profile_nil?
    AdopterProfile.where(adopter_account_id: current_user.adopter_account.id)[0].nil?
  end
end
