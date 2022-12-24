require "test_helper"

class ContactFormTest < ActionDispatch::IntegrationTest
  test 'All errors and custom messages appear on blank form submission' do
    sign_in users(:user_four)

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
end
