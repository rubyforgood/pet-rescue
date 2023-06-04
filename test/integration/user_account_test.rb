require "test_helper"

class UserAccountTest < ActionDispatch::IntegrationTest

  setup do
    @email = users(:adopter_without_profile).email
  end

  test "user gets redirected to root page after sign in" do
    user = users(:adopter_with_profile)

    post '/users/sign_in',
      params: { user:
                {
                  email: user.email,
                  password: 'password'
                },
                commit: 'Log in'
      }

    assert_redirected_to root_path
    assert_equal 'Signed in successfully.', flash[:notice]
  end

  test "user gets redirected to root page after sign out" do
    sign_in users(:adopter_with_profile)

    delete destroy_user_session_path

    assert_redirected_to root_path
    assert_equal 'Signed out successfully.', flash[:notice]
  end

  test "Adopter user can sign up with an associated adopter account and sees success flash and welcome mail is sent" do
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

    mail = ActionMailer::Base.deliveries[0]
    assert_equal mail.from.join, 'bajapetrescue@gmail.com', 'from email is incorrect'
    assert_equal mail.to.join, 'foo@bar.baz', 'to email is incorrect'
    assert_equal mail.subject, 'Welcome to Baja Pet Rescue', 'subject is incorrect'
    ActionMailer::Base.deliveries = []

    assert_response :redirect
    follow_redirect!

    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
    assert(User.find_by(first_name: 'Foo'))
    assert_equal AdopterAccount.last.user_id, User.last.id
  end

  test "Staff user can sign up with an unverified staff account belonging to organization id 1 and see success flash" do
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

    mail = ActionMailer::Base.deliveries
    assert_equal mail[0].from.join, 'bajapetrescue@gmail.com', 'from email is incorrect'
    assert_equal mail[0].to.join, 'abc@123.com', 'to email is incorrect'
    assert_equal mail[0].subject, 'Welcome to Baja Pet Rescue', 'subject is incorrect'
    assert_equal mail[1].from.join, 'bajapetrescue@gmail.com', 'from email is incorrect'
    assert_equal mail[1].to.join, 'wcrwater@gmail.com', 'to email is incorrect'
    assert_equal mail[1].subject, 'New Staff Account', 'subject is incorrect'
    ActionMailer::Base.deliveries = []

    assert_response :redirect
    follow_redirect!

    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
    assert(User.find_by(first_name: 'Ima'))
    assert(StaffAccount.find_by(organization_id: 1))
  end

  test 'error messages should appear if edit profile form is submitted without data' do
    sign_in users(:adopter_without_profile)

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

  test 'user cannot update their profile with invalid password and should see error message' do
    sign_in users(:adopter_without_profile)

    put '/users',
    params: { user:
              {
                email: 'test@test123.com',
                first_name: 'Billy',
                last_name: 'Noprofile',
                password: '',
                password_confirmation: '',
                current_password: 'badpass'
              },
      commit: 'Update'
    }

    assert_response :success
    assert_select 'div.alert', count: 1
    assert_select 'div.alert', 'Current password is invalid'

    users(:adopter_without_profile).reload
    assert users(:adopter_without_profile).valid_password?('password'), 'Password updated without proper authorization'
  end

  test 'user can update their password and see success flash' do
    sign_in users(:adopter_without_profile)

    put '/users',
    params: { user:
              {
                email: 'test@test123.com',
                first_name: 'Billy',
                last_name: 'Noprofile',
                password: 'newpassword',
                password_confirmation: 'newpassword',
                current_password: 'password'
              },
      commit: 'Update'
    }

    assert_response :redirect
    assert_equal 'Your account has been updated successfully.', flash[:notice]

    users(:adopter_without_profile).reload
    assert users(:adopter_without_profile).valid_password?('newpassword'), 'Updated password is not valid'
  end

  test 'user can update their first name and see success flash' do
    sign_in users(:adopter_without_profile)

    put '/users',
    params: { user:
              {
                email: 'test@test123.com',
                first_name: 'Etzio',
                last_name: 'Auditore',
                password: '',
                password_confirmation: '',
                current_password: 'password'
              },
      commit: 'Update'
    }

    assert_response :redirect
    assert_equal 'Your account has been updated successfully.', flash[:notice]

    users(:adopter_without_profile).reload
    assert_equal 'Etzio', users(:adopter_without_profile).first_name
    assert_equal 'Auditore', users(:adopter_without_profile).last_name
  end

  test "user can delete their account" do
    sign_in users(:adopter_without_profile)
    assert(users(:adopter_without_profile))
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

  test "email is sent when a user goes through Forgot Password flow" do
    post '/users/password',
    params: { user:
      {
        email: @email
      },
      commit: 'Send me reset password instructions'
    }

    mail = ActionMailer::Base.deliveries[0]
    assert_equal mail.from.join, 'please-change-me-at-config-initializers-devise@example.com', 'from email is incorrect'
    assert_equal mail.to.join, @email, 'to email is incorrect'
    assert_equal mail.subject, 'Reset password instructions', 'subject is incorrect'
    ActionMailer::Base.deliveries = []
  end
end
