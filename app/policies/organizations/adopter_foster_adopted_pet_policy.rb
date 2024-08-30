class Organizations::AdopterFosterAdoptedPetPolicy < ApplicationPolicy
  pre_check :verify_adopter_foster_account!

  relation_scope do |relation|
    relation.where(adopter_foster_account_id: user.adopter_foster_account.id)
  end

  def index?
    permission?(:view_adopted_pets)
  end
end
