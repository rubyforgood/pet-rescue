# class to create a new organization, user, staff account with role admin, and send email via the console
class CreateOrgAndAdminService
  def initialize
    instructions
    @success_counter = 0
  end

  def create_organization(name, slug)
    return puts "Organization with that name or slug already exists" if org_name_or_slug_in_use?(name, slug)

    @organization = Organization.new(
      name: name,
      slug: slug
    )

    if @organization.save
      puts "Organization created"
      @success_counter += 1
    else
      puts "Organization has the following errors: #{@organization.errors}"
    end
  end

  def create_user(email, first_name, last_name)
    return puts "Organization required" unless @organization

    ActsAsTenant.with_tenant(@organization) do
      @user = User.new(
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: SecureRandom.hex(3)[0, 6],
        tos_agreement: 1
      )

      if @user.save
        puts "User created"
        @success_counter += 1
      else
        puts "User has the following errors: #{@user.errors}"
      end
    end
  end

  def create_staff_account
    return puts "Organization and User required" unless @organization && @user

    ActsAsTenant.with_tenant(@organization) do
      @staff_account = StaffAccount.new(
        organization_id: @organization.id,
        user_id: @user.id,
        verified: 1
      )

      if @staff_account.save
        puts "Staff Account created"
        @success_counter += 1
      else
        puts "Staff Account has the following errors: #{@staff_account.errors}"
      end
    end
  end

  def add_admin_role_to_staff_account
    return puts "Staff Account required" unless @staff_account

    @staff_account.add_role(:admin)

    if @staff_account.has_role?(:admin)
      puts "Admin role added to Staff Account"
      @success_counter += 1
    else
      puts "**Role not added**"
    end
  end

  def send_email
    return puts "**One or more of the prior steps failed. Email not sent.**" unless @success_counter == 4

    OrganizationMailer.with(
      user: @user,
      organization: @organization,
    )
      .create_new_org_and_admin(@organization.slug).deliver_now
  end

  private

  def instructions
    puts "Use the following methods and arguments in order to create a new Organization and Admin user:"
    puts "  create_organization(name, slug)"
    puts "  create_user(email, first_name, last_name)"
    puts "  create_staff_account"
    puts "  add_admin_role_to_staff_account"
    puts "  send_email"
  end

  def org_name_or_slug_in_use?(name, slug)
    Organization.exists?(name: name) || Organization.exists?(slug: slug)
  end
end
