module PetsHelper
  def status_badge(pet)
    if pet.has_adoption_pending?
      render BadgeComponent.new("Adoption Pending", class: "badge bg-info")
    elsif pet.is_adopted?
      render BadgeComponent.new("Adopted", class: "badge bg-warning")
    elsif pet.in_foster?
      render BadgeComponent.new("In Foster", class: "badge text-white bg-dark-primary")
    elsif pet.open?
      render BadgeComponent.new("Open", class: "badge bg-light-warning text-dark")
    else
      ""
    end
  end
end
