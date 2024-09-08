# == Schema Information
#
# Table name: adopter_applications
#
#  id                        :bigint           not null, primary key
#  notes                     :text
#  profile_show              :boolean          default(TRUE)
#  status                    :integer          default("awaiting_review")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  adopter_foster_account_id :bigint
#  form_submission_id        :bigint           not null
#  organization_id           :bigint           not null
#  pet_id                    :bigint           not null
#
# Indexes
#
#  index_adopter_applications_on_form_submission_id  (form_submission_id)
#  index_adopter_applications_on_organization_id     (organization_id)
#  index_adopter_applications_on_pet_id              (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (adopter_foster_account_id => adopter_foster_accounts.id)
#  fk_rails_...  (form_submission_id => form_submissions.id)
#  fk_rails_...  (pet_id => pets.id)
#
class AdopterApplication < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :pet, touch: true
  belongs_to :form_submission

  broadcasts_refreshes

  enum :status, [:awaiting_review,
    :under_review,
    :adoption_pending,
    :withdrawn,
    :successful_applicant,
    :adoption_made,
    :awaiting_data]

  validates :form_submission,
    uniqueness: {
      scope: :pet,
      message: "has already applied for this pet."
    }
  # remove adoption_made status as not necessary for staff
  def self.app_review_statuses
    AdopterApplication.statuses.keys.map do |status|
      unless status == "adoption_made"
        [status.titleize, status]
      end
    end.compact!
  end

  # check if an adopter has applied to adopt a pet
  def self.adoption_exists?(form_submission_id, pet_id)
    AdopterApplication.where(form_submission_id: form_submission_id,
      pet_id: pet_id).exists?
  end

  # check if any applications are set to profile_show: true
  def self.any_applications_profile_show_true?(form_submission_id)
    applications = AdopterApplication.where(form_submission_id: form_submission_id)
    applications.any? { |app| app.profile_show == true }
  end

  def self.retire_applications(pet_id:)
    where(pet_id:).each do |adopter_application|
      adopter_application.update!(status: :adoption_made)
    end
  end

  def applicant_name
    form_submission.person.name
  end

  def withdraw
    update!(status: :withdrawn)
  end

  ransacker :applicant_name do 
    Arel.sql("people.name")
  end

  ransacker :status, formatter: proc { |v| statuses[v] } do |parent|
    parent.table[:status]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["applicant_name", "status"]
  end
end
