class ActiveStorage::AttachmentPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!, only: [:purge?]

  def purge?
    permission?(:purge_attachments)
  end

  def purge_avatar?
    permission?(:purge_avatar)
  end

  private

  def organization
    @organization || record.record.organization
  end
end
