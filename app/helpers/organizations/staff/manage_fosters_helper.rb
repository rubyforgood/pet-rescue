module Organizations::Staff::ManageFostersHelper
  def status_classes(status)
    case status
    when :complete
      "text-black bg-light-success"
    when :upcoming
      "text-black bg-light-warning"
    when :current
      "text-white bg-dark-primary"
    end
  end
end
