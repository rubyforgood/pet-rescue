module AdoptionApplicationReviewsHelper
  def application_status_classes(application)
    status_classes = {awaiting_review: "text-white bg-dark-primary",
                      under_review: "text-white bg-dark-info",
                      adoption_pending: "text-black bg-light-warning",
                      withdrawn: "text-black bg-gray-200",
                      successful_applicant: "text-black bg-light-success",
                      adoption_made: "text-black bg-light-success"}

    status_classes[application.status.to_sym]
  end
end
