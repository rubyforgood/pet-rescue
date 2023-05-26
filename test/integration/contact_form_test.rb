require "test_helper"

class ContactFormTest < ActionDispatch::IntegrationTest
  test 'All errors and custom messages appear on blank form submission' do
    sign_in users(:adopter_without_profile)

    get '/contacts',
			params: {
				name: '',
				email: '',
				message: '',
				commit: 'Submit'
			}

    assert_select 'div.alert', 'Please fix 3 errors highlighted below.', count: 1
    assert_select 'div.alert', "Name can't be blank", count: 1
    assert_select 'div.alert', "Email can't be blank", count: 1
    assert_select 'div.alert', "Message can't be blank", count: 1
  end

  test 'should successfully submit form' do
    sign_in users(:adopter_without_profile)

    assert_emails 1 do
      get '/contacts',
        params: {
          name: 'Samuel',
          email: 'samuel@jackson.com',
          message: 'Example help message.',
          commit: 'Submit'
        }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_equal flash[:notice], 'Message sent!'
  end
end
