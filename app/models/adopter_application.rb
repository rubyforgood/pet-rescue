class AdopterApplication < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account

  enum :status, [:awaiting_review, 
                 :under_review,
                 :adoption_pending,
                 :withdrawn,
                 :successful_applicant,
                 :adoption_made]

  # remove adoption_made status as not necessary for staff
  def self.app_review_statuses
    AdopterApplication.statuses.keys.map do |status|
      unless status == 'adoption_made'
        [status.titleize, status]
      end
    end.compact!
  end

  # check if an adopter has applied to adopt a dog
  def self.adoption_exists?(adopter_account_id, dog_id)
    AdopterApplication.where(adopter_account_id: adopter_account_id,
                             dog_id: dog_id).exists?
  end

end
