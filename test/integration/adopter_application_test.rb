require "test_helper"

class AdopterApplicationTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = dogs(:one).id
    @paused_dog_id = dogs(:paused_application).id
  end

  test "adopter user without profile cannot apply for dog and sees flash error" do
    sign_in users(:adopter_without_profile)
    before_count = AdopterApplication.all.count

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: adopter_accounts(:adopter_account_two).id,
        dog_id: @dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]

    assert_equal before_count, AdopterApplication.all.count
  end

  test "staff user sees flash error if they apply for a dog" do
    sign_in users(:verified_staff_one)
    before_count = AdopterApplication.all.count

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: nil,
        dog_id: @dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]

    assert_equal before_count, AdopterApplication.all.count
  end

  test "adopter user with profile can apply for a dog and staff receive email" do
    sign_in users(:adopter_with_profile)
    before_count = AdopterApplication.all.count

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: adopter_accounts(:adopter_account_one).id,
        dog_id: @dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Application submitted! Woof woof.', flash[:notice]
    assert_equal AdopterApplication.all.count, before_count + 1

    mail = ActionMailer::Base.deliveries
    assert_equal mail[0].from.join, 'bajapetrescue@gmail.com', 'from email is incorrect'
    assert_equal mail[0].to.join(' '), 'testes@test.com purple@haze.com', 'to email is incorrect'
    assert_equal mail[0].subject, 'New Adoption Application', 'subject is incorrect'
  end

  test "adopter user with profile cannot apply for a paused dog and sees flash error" do
    sign_in users(:adopter_with_profile)
    before_count = AdopterApplication.all.count

    post '/create_my_application',
    params: { application:
      {
        adopter_account_id: adopter_accounts(:adopter_account_one).id,
        dog_id: @paused_dog_id
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Applications are paused for this dog', flash[:alert]

    assert_equal before_count, AdopterApplication.all.count
  end

end
