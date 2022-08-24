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
end
