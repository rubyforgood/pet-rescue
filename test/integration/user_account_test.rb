require "test_helper"

class UserAccountTest < ActionDispatch::IntegrationTest

  test "Adopter user can sign up with an associated adopter account" do
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

    assert(User.find_by(first_name: 'Foo'))
    assert_equal AdopterAccount.last.user_id, User.last.id
  end

  test "Staff user can sign up with an associated unverified staff account belonging to organization id 1" do
    # set org id to 1 to match the default value. Cannot pass org_id as it's not permitted param.
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

    assert(User.find_by(first_name: 'Ima'))
    assert(StaffAccount.find_by(organization_id: 1))
  end

  # check user can delete account
end
