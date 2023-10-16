# class to create a new location, organization, organization profile, user, and staff account with role admin
# email is sent to admin user if all steps are successful
# call with Organizations::CreateService.new.signal(args)
# sample args:
# {
#   location: {
#     country: 'Mexico',
#     city_town: 'La Ventana',
#     province_state: 'Baja'
#   },
#   organization: {
#     name: 'Baja Pet Rescue',
#     slug: 'baja'
#   },
#   user: {
#     email: 'test@test.lol',
#     first_name: 'Jimmy',
#     last_name: 'Hendrix'
#   }
# }

class Organizations::CreateService
  def signal(args)
    ActiveRecord::Base.transaction do
      create_location(
        args[:location][:country],
        args[:location][:city_town],
        args[:location][:province_state]
      )
      create_organization_and_profile(
        args[:organization][:name],
        args[:organization][:slug]
      )
      create_user(
        args[:user][:email],
        args[:user][:first_name],
        args[:user][:last_name]
      )
      create_staff_account
      add_admin_role_to_staff_account
      send_email
    end
  rescue => e
    raise "An error occurred: #{e.message}"
  end

  private

  def create_location(country, city_town, province_state)
    @location = Location.create!(
      country: country,
      city_town: city_town,
      province_state: province_state
    )
  end

  def create_organization_and_profile(name, slug)
    @organization = Organization.create!(
      name: name,
      slug: slug,
      profile: OrganizationProfile.new(
        location_id: @location.id
      )
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
