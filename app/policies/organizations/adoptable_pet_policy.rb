class Organizations::AdoptablePetPolicy < ApplicationPolicy
  skip_pre_check :verify_authenticated!, only: %i[show?]

  relation_scope do |relation|
    relation.where(published: true).where.missing(:matches)
  end

  def show?
    allow! if allowed_to?(:manage?, record, namespace: Organizations)

    published? && !record.application_paused && record.matches.empty?
  end

  private

  def published?
    record.published?
  end
end
