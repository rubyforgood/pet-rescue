require "test_helper"

class Organizations::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pets = create_list(:pet, 4, :with_image)
    set_organization(@pets.first.organization)
  end

  context "GET #index" do
    should "render index template" do
      get home_index_path

      assert_response :success
      assert_select "title", text: "#{ActsAsTenant.current_tenant.name} | \"Pet Rescue\""
    end

    should "render four random organization pets" do
      get home_index_path

      assert_response :success
      @pets.each { |pet| assert_select "p", "Adopt #{pet.name}" }
    end
  end
end
