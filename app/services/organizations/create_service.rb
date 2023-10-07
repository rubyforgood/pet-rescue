# class to create a new organization, user, staff account with role admin, and send email via the console
# call with Organizations::CreateService.new.signal(args)
# args:
# {
#   organization_name: 'value',
#   organization_slug: 'value',
#   user_email: 'value',
#   user_first_name: 'value',
#   user_last_name: 'value'
# }

class Organizations::CreateService
  def signal(args)
    ActiveRecord::Base.transaction do
      create_organization(args[:organization_name], args[:organization_slug])
      create_user(args[:user_email], args[:user_first_name], args[:user_last_name])
      create_staff_account
      add_admin_role_to_staff_account
      send_email
    end
  rescue => e
    puts "An error occurred: #{e.message}"
  end

  def create_organization(name, slug)
    @organization = Organization.create!(
      name: name,
      slug: slug
    )
  end

  def create_user(email, first_name, last_name)
    ActsAsTenant.with_tenant(@organization) do
      @user = User.create!(
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: SecureRandom.hex(3)[0, 6],
        tos_agreement: 1
      )
    end
  end

  def create_staff_account
    ActsAsTenant.with_tenant(@organization) do
      @staff_account = StaffAccount.create!(
        organization_id: @organization.id,
        user_id: @user.id,
        verified: 1
      )
    end
  end

  def add_admin_role_to_staff_account
    @staff_account.add_role(:admin)

    if !@staff_account.has_role?(:admin)
      raise StandardError, "Failed to add admin role"
    end
  end

  def send_email
    OrganizationMailer.with(
      user: @user,
      organization: @organization
    )
      .create_new_org_and_admin(@organization.slug).deliver_now
  end
end
