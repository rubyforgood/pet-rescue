require "test_helper"

class AdoptableDogShowTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = Dog.where(name: 'Applications')[0].id
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

  # https://stackoverflow.com/questions/7098499/how-to-use-assert-select-to-test-for-presence-of-a-given-link
  # test "adopter with a profile sees button to apply to adopt" do
  #   sign_in users(:user_four)
  #   adopter_account_id = users(:user_four).adopter_account.id
  #   get "/adoptable_dogs/#{@dog_id}"
  #   assert_response :success
  #   assert_select 'form[action=?]', create_my_application_path(application: { 
  #     dog_id: @dog_id, 
  #     adopter_account_id: adopter_account_id})
  # end
end
