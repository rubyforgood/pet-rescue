class ActiveStorage::AttachmentPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def purge?
    permission?(:purge_attachments)
  end

  private

  def organization
    @organization || record.record.organization
  end
end
