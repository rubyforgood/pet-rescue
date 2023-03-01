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

  # check if any applications are set to profile_show: true
  def self.any_applications_profile_show_true?(adopter_account_id)
    applications = AdopterApplication.where(adopter_account_id: adopter_account_id)
    applications.any? { |app| app.profile_show == true }
  end

  # set application status to withdrawn e.g. if reverting an adoption
  def self.set_status_to_withdrawn(adopter_application)
    adopter_application.status = :withdrawn
    adopter_application.save
  end
end
