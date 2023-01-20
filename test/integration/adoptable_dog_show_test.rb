require "test_helper"

class AdoptableDogShowTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = dogs(:dog_three).id
  end

  test "unauthenticated users see create account prompt and link" do
    get "/adoptable_dogs/#{@dog_id}"
    assert_response :success
    assert_select "h4", "Create an account to apply for this dog"
    assert_select "a", "Create Account"
  end

  test "adopter without a profile sees complete my profile prompt and link" do
    sign_in users(:user_four)
    get "/adoptable_dogs/#{@dog_id}"
    assert_response :success
    assert_select "h4", "Complete your profile to apply for this dog"
    assert_select "a", "Complete my profile"
  end

  test "adopter with a profile sees love this pooch question and apply button" do
    sign_in users(:user_one)
    get "/adoptable_dogs/#{@dog_id}"
    assert_response :success
    assert_select "h4", "In love with this pooch?"
    assert_select 'form' do
      assert_select 'button', 'Apply to Adopt'
    end
  end

  test "staff do not see an adopt button only log out button" do
    sign_in users(:user_two)
    get "/adoptable_dogs/#{@dog_id}"
    assert_response :success
    assert_select 'form' do
      assert_select 'button', 'Log Out'
    end
    assert_select 'form', count: 1
  end

  test "if dog status is paused and reason is opening soon this is displayed" do
    sign_in users(:user_two)

    put "/dogs/#{@dog_id}",
      params: { dog:
      {
        organization_id: "#{organizations(:organization_one).id}",
        name: 'TestDog',
        age: '7',
        sex: 'Female',
        breed: 'mix',
        size: 'Medium (22-57 lb)',
        description: 'A lovely little pooch this one.',
        append_images: [''],
        application_paused: true,
        pause_reason: 'opening_soon'
      }
    }

    logout
    sign_in users(:user_one)
    get "/adoptable_dogs/#{@dog_id}"
    assert_select "h3", "Applications Opening Soon"  
  end

  test "if dog status is paused and reason is paused until further notice this is displayed" do
    sign_in users(:user_two)

    put "/dogs/#{@dog_id}",
      params: { dog:
        {
          organization_id: "#{organizations(:organization_one).id}",
          name: 'TestDog',
          age: '7',
          sex: 'Female',
          breed: 'mix',
          size: 'Medium (22-57 lb)',
          description: 'A lovely little pooch this one.',
          append_images: [''],
          application_paused: true,
          pause_reason: 'paused_until_further_notice'
        } }

    logout
    sign_in users(:user_one)
    get "/adoptable_dogs/#{@dog_id}"
    assert_select "h3", "Applications Paused Until Further Notice"  
  end
end
