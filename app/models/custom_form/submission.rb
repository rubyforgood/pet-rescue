# == Schema Information
#
# Table name: submissions
#
#  id                        :bigint           not null, primary key
#  notes                     :text
#  profile_show              :boolean          default(TRUE)
#  status                    :integer          default("awaiting_review")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  adopter_foster_account_id :bigint           not null
#  organization_id           :bigint           not null
#  pet_id                    :bigint           not null
#
# Indexes
#
#  index_submissions_on_adopter_foster_account_id             (adopter_foster_account_id)
#  index_submissions_on_organization_id                       (organization_id)
#  index_submissions_on_pet_id                                (pet_id)
#  index_submissions_on_pet_id_and_adopter_foster_account_id  (pet_id,adopter_foster_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (adopter_foster_account_id => adopter_foster_accounts.id)
#  fk_rails_...  (pet_id => pets.id)
#
module CustomForm
  class Submission < ApplicationRecord
    acts_as_tenant(:organization)
    belongs_to :pet, touch: true
    belongs_to :adopter_foster_account

    broadcasts_refreshes

    enum :status, [:awaiting_review,
      :under_review,
      :adoption_pending,
      :withdrawn,
      :successful_applicant,
      :adoption_made]

    validates :adopter_foster_account,
      uniqueness: {
        scope: :pet,
        message: "has already applied for this pet."
      }
    # remove adoption_made status as not necessary for staff
    def self.app_review_statuses
      CustomForm::Submission.statuses.keys.map do |status|
        unless status == "adoption_made"
          [status.titleize, status]
        end
      end.compact!
    end

    # check if an adopter has applied to adopt a pet
    def self.adoption_exists?(adopter_foster_account_id, pet_id)
      CustomForm::Submission.where(adopter_foster_account_id: adopter_foster_account_id,
        pet_id: pet_id).exists?
    end

    # check if any submissions are set to profile_show: true
    def self.any_submissions_profile_show_true?(adopter_foster_account_id)
      submissions = CustomForm::Submission.where(adopter_foster_account_id: adopter_foster_account_id)
      submissions.any? { |app| app.profile_show == true }
    end

    def self.retire_submissions(pet_id:)
      where(pet_id:).each do |submission|
        submission.update!(status: :adoption_made)
      end
    end

    def applicant_name
      adopter_foster_account.user.full_name.to_s
    end

    def withdraw
      update!(status: :withdrawn)
    end

    ransacker :applicant_name do
      Arel.sql("CONCAT(users.last_name, ', ', users.first_name)")
    end

    ransacker :status, formatter: proc { |v| statuses[v] } do |parent|
      parent.table[:status]
    end

    def self.ransackable_attributes(auth_object = nil)
      ["applicant_name", "status"]
    end
  end
end
