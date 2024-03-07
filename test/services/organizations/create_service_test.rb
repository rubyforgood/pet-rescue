require "test_helper"

class Organizations::CreateServiceTest < ActiveSupport::TestCase
  test "it creates page_text when organization is created" do
    args = {
      location: {
        country: "Mexico",
        city_town: "La Ventana",
        province_state: "Baja"
      },
      organization: {
        name: "Baja Pet Rescue",
        slug: "baja"
      },
      user: {
        email: "test@test.lol",
        first_name: "Jimmy",
        last_name: "Hendrix"
      }
    }

    Organizations::CreateService.new.signal(args)
    assert_not Organization.last.page_text.nil?
  end
end
