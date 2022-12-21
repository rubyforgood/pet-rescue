require "test_helper"

class AdopterApplicationTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = Dog.find_by(name: 'Deleted').id
  end

  test "adopter user without profile sees flash error if they apply for a dog" do
    count_before = AdopterApplication.all.count
    sign_in users(:user_four)

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: users(:user_four).id,
        dog_id: @dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]

    count_after = AdopterApplication.all.count
    assert_equal count_before, count_after
  end

  test "staff user sees flash error if they apply for a dog" do
  end

  test "adopter user with profile can apply for a dog and staff receive email" do
    count_before = AdopterApplication.all.count
    sign_in users(:user_one)

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: users(:user_one).id,
        dog_id: @dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Application submitted! Woof woof.', flash[:notice]

    
   #  assert_equal 2, AdopterApplication.all.count
  end

  test "adopter user with profile sees flash error if they apply for a paused dog" do
  end

end
