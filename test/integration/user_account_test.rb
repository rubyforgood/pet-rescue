require "test_helper"

class UserAccountTest < ActionDispatch::IntegrationTest

  test "Adopter user can sign up with an associated adopter account and sees success flash" do
    post "/users",
      params: { user:
        {
          adopter_account_attributes: {
            user_id: ''
          },
          email: 'foo@bar.baz',
          first_name: 'Foo',
          last_name: 'Bar',
          password: '123456',
          password_confirmation: '123456',
          tos_agreement: '1'
        },
        commit: 'Create Account' }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
    assert(User.find_by(first_name: 'Foo'))
    assert_equal AdopterAccount.last.user_id, User.last.id
  end

  test "Staff user can sign up with an unverified staff account belonging to organization id 1 and see success flash" do
    # set org id to 1 to match db default value. Cannot pass org_id as it's not permitted param.
    organization = Organization.find_by(name: 'for_staff_sign_up')
    organization.id = 1
    organization.save

    post "/users",
      params: { user:
        {
          staff_account_attributes: {
            user_id: ''
          },
          email: 'abc@123.com',
          first_name: 'Ima',
          last_name: 'Staff',
          password: 'password',
          password_confirmation: 'password',
          tos_agreement: '1'
        },
        commit: 'Create Account' }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
    assert(User.find_by(first_name: 'Ima'))
    assert(StaffAccount.find_by(organization_id: 1))
  end

  test 'error messages should appear if edit profile form is submitted without data' do
    sign_in users(:user_four)

    put '/users',
    params: { user:
              {
                email: '',
                first_name: '',
                last_name: '',
                password: '',
                password_confirmation: '',
                current_password: 'password'
              },
      commit: 'Update'
    }

    assert_response :success
    assert_select 'div.alert', count: 3
    assert_select 'div.alert', "Email can't be blank"
    assert_select 'div.alert', "First name can't be blank"
    assert_select 'div.alert', "Last name can't be blank"
  end

  test "user can delete their account" do
    sign_in users(:user_four)
    assert(User.find_by(email: 'test@test123.com'))
    delete '/users'
    assert_nil(User.find_by(email: 'test@test123.com'))
  end

  test "error messages appear if sign up form is submitted without data" do 
    post '/users',
    params: { user: 
      {
        adopter_account_attributes: {
          user_id: ''
          },
        email: '',
        first_name: '',
        last_name: '',
        password: '',
        password_confirmation: '',
        tos_agreement: '0'
      },
      commit: 'Create Account'
    }

    assert_select 'div.alert', 'Please accept the Terms and Conditions'
    assert_select 'div.alert', "Email can't be blank"
    assert_select 'div.alert', "Password can't be blank"
    assert_select 'div.alert', "First name can't be blank"
    assert_select 'div.alert', "Last name can't be blank"
    assert_select 'div.alert', "Tos agreement Please accept the Terms and Conditions"
  end
end
