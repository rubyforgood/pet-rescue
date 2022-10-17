require "test_helper"

class AdoptableDogShowTest < ActionDispatch::IntegrationTest

  # get dog id from fixture
  # dog_id = Dog.where(name: '')[0].id

  # test "unauthenticated users can see dog show page and sign up button" do
  #   get "/adoptable_dogs/#{dog_id}"
  #   assert_response :success
  #   #assert_select "a", "Sign up to be able to apply for this dog"
  # end

  # test "adopter without a profile can see dog show and complete profile button" do
  #   sign_in users(:user_one)
  #   get "/adoptable_dogs/#{dog_id}"
  #   assert_response :success
  #   #assert_select "a", "You need to complete your profile before you can apply"
  # end

  # signed up but no profile see button that says complete profile
  # adopter with profile see button to adopt
end
